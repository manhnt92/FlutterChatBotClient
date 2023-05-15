import 'dart:async';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SQLite {

  static final SQLite instance = SQLite._internal();
  factory SQLite() => instance;
  SQLite._internal();

  static const String chatHistoryTable = 'chat_history';
  static const String chatHistoryColumnId = 'id';
  static const String chatHistoryColumnQuestion = 'question';
  static const String chatHistoryColumnAnswer = 'answer';
  static const String chatHistoryColumnConversationId = 'conversation_id';

  static const String conversationTable = 'conversation';
  static const String conversationColumnId = 'id';
  static const String conversationColumnTitle = 'title';
  static const String conversationColumnDesc = 'desc';
  static const String conversationColumnType = 'type';

  late Database _database;
  final Map<int, List<String>> _migrationScripts = {
    1 : [
      'CREATE TABLE $chatHistoryTable('
          '$chatHistoryColumnId INTEGER PRIMARY KEY,'
          '$chatHistoryColumnQuestion TEXT,'
          '$chatHistoryColumnAnswer TEXT,'
          '$chatHistoryColumnConversationId INTEGER,'
          'created_at DATETIME DEFAULT CURRENT_TIMESTAMP'
      ')',
      'CREATE TABLE $conversationTable('
          '$conversationColumnId INTEGER PRIMARY KEY,'
          '$conversationColumnTitle TEXT,'
          '$conversationColumnDesc TEXT,'
          '$conversationColumnType INTEGER DEFAULT 1,'
          'created_at DATETIME DEFAULT CURRENT_TIMESTAMP'
      ')'
    ]
  };

  Future<void> init() async {
    if (Utils.instance.isWin32) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    } else if (Utils.instance.isWeb) {
      //dart run sqflite_common_ffi_web:setup
      //dart run sqflite_common_ffi_web:setup --force
      databaseFactory = databaseFactoryFfiWeb;
    }
    var dbPath = join(await getDatabasesPath(), 'chat_bot.db');
    debugPrint("db path = $dbPath");
    _database = await openDatabase(dbPath,
      onCreate : (db, version) async {
        for (int i = 1; i <= _migrationScripts.length; i++) {
          if (_migrationScripts[i] != null) {
            for (String script in _migrationScripts[i]!) {
              debugPrint("on create : execute script : $script");
              db.execute(script);
            }
          }
        }
      },
      onUpgrade: (db, int oldVersion, int newVersion) async {
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          if (_migrationScripts[i] != null) {
            for (String script in _migrationScripts[i]!) {
              debugPrint("on upgrade : execute script : $script");
              db.execute(script);
            }
          }
        }
      },
      onOpen: (db) async {},
      version: _migrationScripts.length
    );
  }

  void dispose() {
    _database.close();
  }

  Future<Conversation> insertConversation(String title, String desc, int type) async {
    Map<String, dynamic> map = {
      conversationColumnTitle : title,
      conversationColumnDesc : desc,
      conversationColumnType : type
    };
    int id = await _database.insert(conversationTable, map, conflictAlgorithm: ConflictAlgorithm.replace);
    return Conversation(id: id, title: title, desc: desc, type: type);
  }

  Future<void> updateConversation(Conversation conv) async {
    Map<String, dynamic> map = {
      conversationColumnTitle : conv.title,
      conversationColumnDesc : conv.desc,
      conversationColumnType : conv.type
    };
    await _database.update(conversationTable, map, where: 'id = ?', whereArgs: [conv.id]);
  }

  Future<void> deleteConversation(Conversation conv) async {
    await _database.delete(conversationTable, where: 'id = ?', whereArgs: [conv.id]);
  }

  Future<List<Conversation>> getAllConversation() async {
    final List<Map<String, dynamic>> maps = await _database.query(conversationTable);
    return List.generate(maps.length, (i) {
      return Conversation(
        id: maps[i][conversationColumnId],
        title: maps[i][conversationColumnTitle],
        desc: maps[i][conversationColumnDesc],
        type: maps[i][conversationColumnType]
      );
    });
  }

  Future<QAMessage> insertQAMessage({required Conversation conv, required String question, String answer = ""}) async {
    Map<String, dynamic> map = {
      chatHistoryColumnQuestion : question,
      chatHistoryColumnAnswer : answer,
      chatHistoryColumnConversationId : conv.id
    };
    debugPrint('insert QA Message: $map');
    int id = await _database.insert(chatHistoryTable, map, conflictAlgorithm: ConflictAlgorithm.replace);
    return QAMessage(id: id, question: question, answer: answer, conversationId: conv.id, canPlayAnswerAnim: true);
  }

  Future<void> updateQAMessage(QAMessage message) async {
    Map<String, dynamic> map = {
      chatHistoryColumnQuestion : message.question,
      chatHistoryColumnAnswer : message.answer,
      chatHistoryColumnConversationId : message.conversationId
    };
    debugPrint('update QA Message: $map');
    await _database.update(chatHistoryTable, map, where: 'id = ?', whereArgs: [message.id]);
  }

  Future<void> deleteQAMessage(QAMessage message) async {
    await _database.delete(chatHistoryTable, where: 'id = ?', whereArgs: [message.id]);
  }

  Future<List<QAMessage>> getAllQAMessage(Conversation conv) async {
    final List<Map<String, dynamic>> maps = await _database.query(chatHistoryTable, where: '$chatHistoryColumnConversationId = ?', whereArgs: [conv.id]);
    debugPrint('getAllQAMessage: conv_id=${conv.id} - $maps');
    return List.generate(maps.length, (i) {
      return QAMessage(
          id: maps[i][chatHistoryColumnId],
          question: maps[i][chatHistoryColumnQuestion],
          answer: maps[i][chatHistoryColumnAnswer],
          conversationId: maps[i][chatHistoryColumnConversationId],
          canPlayAnswerAnim: false
      );
    });
  }

  Future<List<QAMessage>> getAllQAMessages() async {
    final List<Map<String, dynamic>> maps = await _database.query(chatHistoryTable);
    debugPrint('getAllQAMessage: - $maps');
    return List.generate(maps.length, (i) {
      return QAMessage(
          id: maps[i][chatHistoryColumnId],
          question: maps[i][chatHistoryColumnQuestion],
          answer: maps[i][chatHistoryColumnAnswer],
          conversationId: maps[i][chatHistoryColumnConversationId],
          canPlayAnswerAnim: false
      );
    });
  }

}