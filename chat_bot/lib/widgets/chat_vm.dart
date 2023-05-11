import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/sqlite.dart';
import 'package:flutter/widgets.dart';

class ChatViewModel with ChangeNotifier {

  Conversation? conversation;
  List<QAMessage> messages = [];

  void getAllMessage() {
    if (conversation != null) {
      SQLite.instance.getAllQAMessage(conversation!).then((value) {
        messages.clear();
        messages.add(QAMessage.createQAMsgTest(question: 'hello', canPlayAnswerAnim: false));
        messages.addAll(value);
        notifyListeners();
      });
    } else {
      messages.add(QAMessage.createQAMsgTest(question: 'hello', canPlayAnswerAnim: false));
    }
  }

  void sendMessage(String text) async {
    conversation ??= await SQLite.instance.insertConversation(text, "", Conversation.typeQA);
    QAMessage message = await SQLite.instance.insertQAMessage(conv: conversation!, question: text);
    messages.add(message);
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      message.setAnswerTest();
      if (conversation != null) {
        conversation!.desc = message.answer;
        SQLite.instance.updateConversation(conversation!);
      }
      SQLite.instance.updateQAMessage(message);
      notifyListeners();
    });
  }

}