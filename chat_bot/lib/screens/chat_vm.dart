import 'dart:async';

import 'package:chat_bot/data/app_web_socket.dart';
import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/data/app_database.dart';
import 'package:flutter/widgets.dart';

enum ChatState {
  disable, type, send, nextQuestion
}

class ChatViewModel with ChangeNotifier {

  List<QAMessage> messages = [];
  Conversation? _conversation;
  ChatState currentState = ChatState.disable;

  late StreamSubscription<dynamic> _socketListener;

  ChatViewModel() {
    _socketListener = AppWebSocket.instance.getWebSocketStream().listen((event) {
      var message = PBCommonMessage.fromBuffer(event);
      if (message.id == 10003 || message.id == 10004) {
        var chat = PBChat.fromBuffer(message.dataBytes);
        if (_conversation != null) {
          var currentMessage = messages[messages.length - 1];
          currentMessage.appendAnswer(chat.message);
          currentMessage.conversationRemoteId = chat.topicId;
          if (message.id == 10004) {
            AppDatabase.instance.updateQAMessage(currentMessage);
          }

          _conversation!.desc = currentMessage.answer;
          _conversation!.remoteId = chat.topicId;
          if (message.id == 10004) {
            AppDatabase.instance.updateConversation(_conversation!);
          }
        }
        if (message.id == 10004) {
          setCurrentState(ChatState.nextQuestion, notify: false);
        }
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _socketListener.cancel();
  }

  void setCurrentState(ChatState state, {bool notify = true}) {
    currentState = state;
    if (notify) {
      notifyListeners();
    }
  }

  void getAllMessage(Conversation? conversation) {
    _conversation = conversation;
    setCurrentState(ChatState.type, notify: false);
    if (conversation != null) {
      AppDatabase.instance.getAllQAMessage(conversation).then((value) {
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
    _conversation ??= await AppDatabase.instance.insertConversation(text, "", Conversation.typeQA);
    QAMessage message = await AppDatabase.instance.insertQAMessage(conv: _conversation!, question: text);
    messages.add(message);
    setCurrentState(ChatState.send, notify: false);
    notifyListeners();

    var msg = PBCommonMessage();
    msg.id = 20003;
    msg.params['msg'] = _createStringValue(text);
    if (_conversation!.remoteId > 0) {
      msg.params['topicId'] = _createIntValue(_conversation!.remoteId);
    }
    AppWebSocket.instance.setPBCommonMessage(msg);
  }

  PBValue _createIntValue(int v) {
    var value = PBValue();
    value.intValue = v;
    return value;
  }

  PBValue _createStringValue(String v) {
    var value = PBValue();
    value.stringValue = v;
    return value;
  }

}