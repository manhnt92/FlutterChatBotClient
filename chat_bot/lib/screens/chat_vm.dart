import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/sqlite.dart';
import 'package:flutter/widgets.dart';

enum ChatState {
  disable, type, send, nextQuestion
}

class ChatViewModel with ChangeNotifier {

  Conversation? _conversation;
  List<QAMessage> messages = [];
  ChatState currentState = ChatState.disable;

  void setCurrentState(ChatState state, {bool notify = true}) {
    currentState = state;
    if (notify) {
      notifyListeners();
    }
  }

  void getAllMessage(Conversation? conversation) {
    _conversation = conversation;
    debugPrint("${_conversation?.title} - ${_conversation?.desc}");
    setCurrentState(ChatState.type, notify: false);
    if (conversation != null) {
      SQLite.instance.getAllQAMessage(conversation).then((value) {
        messages.clear();
        messages.addAll(value);
        notifyListeners();
      });
    } else {
      messages.clear();
      notifyListeners();
    }
  }

  void sendMessage(String text) async {
    _conversation ??= await SQLite.instance.insertConversation(text, "", Conversation.typeQA);
    QAMessage message = await SQLite.instance.insertQAMessage(conv: _conversation!, question: text);
    messages.add(message);
    setCurrentState(ChatState.send, notify: false);
    notifyListeners();

    Future.delayed(const Duration(seconds: 5), () {
      message.setAnswerTest();
      if (_conversation != null) {
        _conversation!.desc = message.answer;
        SQLite.instance.updateConversation(_conversation!);
      }
      SQLite.instance.updateQAMessage(message);
      setCurrentState(ChatState.nextQuestion, notify: false);
      notifyListeners();
    });
  }

}