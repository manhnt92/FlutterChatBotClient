import 'dart:async';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class AppDatabase {

  static final AppDatabase instance = AppDatabase._internal();
  factory AppDatabase() => instance;
  AppDatabase._internal();

  static const String chatTable = 'chat';
  static const String chatColumnId = 'id';
  static const String chatColumnQuestion = 'question';
  static const String chatColumnAnswer = 'answer';
  static const String chatColumnConversationRemoteId = 'conversation_remote_id';

  static const String conversationTable = 'conversation';
  static const String conversationColumnId = 'id';
  static const String conversationColumnRemoteId = 'remote_id';
  static const String conversationColumnTitle = 'title';
  static const String conversationColumnDesc = 'desc';
  static const String conversationColumnType = 'type';

  late Database _database;
  final Map<int, List<String>> _migrationScripts = {
    1 : [
      'CREATE TABLE $chatTable('
          '$chatColumnId INTEGER PRIMARY KEY,'
          '$chatColumnQuestion TEXT,'
          '$chatColumnAnswer TEXT,'
          '$chatColumnConversationRemoteId INTEGER,'
          'created_at DATETIME DEFAULT CURRENT_TIMESTAMP'
      ')',
      'CREATE TABLE $conversationTable('
          '$conversationColumnId INTEGER PRIMARY KEY,'
          '$conversationColumnRemoteId INTEGER,'
          '$conversationColumnTitle TEXT,'
          '$conversationColumnDesc TEXT,'
          '$conversationColumnType INTEGER DEFAULT 1,'
          'created_at DATETIME DEFAULT CURRENT_TIMESTAMP'
      ')'
    ]
  };

  Future<void> init() async {
    if (Utils.isWin32) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    } else if (Utils.isWeb) {
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
      conversationColumnRemoteId : -1,
      conversationColumnTitle : title,
      conversationColumnDesc : desc,
      conversationColumnType : type
    };
    int id = await _database.insert(conversationTable, map, conflictAlgorithm: ConflictAlgorithm.replace);
    return Conversation(id: id, remoteId: -1, title: title, desc: desc, type: type);
  }

  Future<void> updateConversation(Conversation conv) async {
    Map<String, dynamic> map = {
      conversationColumnRemoteId : conv.remoteId,
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
        remoteId: maps[i][conversationColumnRemoteId],
        title: maps[i][conversationColumnTitle],
        desc: maps[i][conversationColumnDesc],
        type: maps[i][conversationColumnType]
      );
    });
  }

  Future<QAMessage> insertQAMessage({required Conversation conv, required String question, String answer = ""}) async {
    Map<String, dynamic> map = {
      chatColumnQuestion : question,
      chatColumnAnswer : answer,
      chatColumnConversationRemoteId: conv.remoteId
    };
    // debugPrint('insert QA Message: $map');
    int id = await _database.insert(chatTable, map, conflictAlgorithm: ConflictAlgorithm.replace);
    return QAMessage(id: id, question: question, answer: answer, conversationRemoteId: conv.remoteId, canPlayAnswerAnim: true);
  }

  Future<void> updateQAMessage(QAMessage message) async {
    Map<String, dynamic> map = {
      chatColumnQuestion : message.question,
      chatColumnAnswer : message.answer,
      chatColumnConversationRemoteId: message.conversationRemoteId
    };
    // debugPrint('update QA Message: $map');
    await _database.update(chatTable, map, where: 'id = ?', whereArgs: [message.id]);
  }

  Future<void> deleteQAMessage(QAMessage message) async {
    await _database.delete(chatTable, where: 'id = ?', whereArgs: [message.id]);
  }

  Future<List<QAMessage>> getAllQAMessage(Conversation conv) async {
    final List<Map<String, dynamic>> maps = await _database.query(chatTable, where: '$chatColumnConversationRemoteId = ?', whereArgs: [conv.remoteId]);
    // debugPrint('getAllQAMessage: conv_id=${conv.id} - $maps');
    return List.generate(maps.length, (i) {
      return QAMessage(
          id: maps[i][chatColumnId],
          question: maps[i][chatColumnQuestion],
          answer: maps[i][chatColumnAnswer],
          conversationRemoteId: maps[i][chatColumnConversationRemoteId],
          canPlayAnswerAnim: false
      );
    });
  }

  Future<List<QAMessage>> getAllQAMessages() async {
    final List<Map<String, dynamic>> maps = await _database.query(chatTable);
    // debugPrint('getAllQAMessage: - $maps');
    return List.generate(maps.length, (i) {
      return QAMessage(
          id: maps[i][chatColumnId],
          question: maps[i][chatColumnQuestion],
          answer: maps[i][chatColumnAnswer],
          conversationRemoteId: maps[i][chatColumnConversationRemoteId],
          canPlayAnswerAnim: false
      );
    });
  }

}