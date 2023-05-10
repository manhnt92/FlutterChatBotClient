import 'dart:async';
import 'package:chat_bot/models/qa_message.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLite {

  static final SQLite instance = SQLite._internal();
  factory SQLite() => instance;
  SQLite._internal();

  late Database database;

  Future<void> init() async {
    database = await openDatabase(join(await getDatabasesPath(), 'chat_bot.db'),
      onCreate : (db, version) {
        db.execute('CREATE TABLE chat_history(id INTEGER PRIMARY KEY, question TEXT, answer TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP)');
      },
      version: 1);
  }

  void dispose() {
    database.close();
  }

  Future<List<QAMessage>> getAllChatHistory() async {
    final List<Map<String, dynamic>> maps = await database.query('chat_history');
    return List.generate(maps.length, (i) {
      return QAMessage(
        id: maps[i]['id'],
        question: maps[i]['question'],
        answer: maps[i]['answer'],
        canPlayAnswerAnim: false
      );
    });
  }

}