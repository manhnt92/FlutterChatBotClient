import 'dart:async';

import 'package:chat_bot/data/app_web_socket.dart';
import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/data/app_database.dart';
import 'package:flutter/widgets.dart';

enum ChatState {
  disable, type, sending, nextQuestion, typeNext
}

class ChatViewModel with ChangeNotifier, SocketEventListener {

  List<QAMessage> messages = [];
  Conversation? _conversation;
  ChatState currentState = ChatState.disable;
  String _pendingSendMessage = "";
  Completer<bool>? _pendingSendMessageCallback;

  ChatViewModel() {
    AppWebSocket.instance.registerEventListener(this);
  }

  @override
  void onWebSocketMessage(message) {
    var pbMsg = PBCommonMessage.fromBuffer(message);
    if (pbMsg.id == 10004) {
      debugPrint('bot answer stream response');
      var chat = PBChat.fromBuffer(pbMsg.dataBytes);
      if (_conversation != null) {
        var currentMessage = messages[messages.length - 1];
        currentMessage.appendAnswer(chat.message);
        currentMessage.conversationRemoteId = chat.topicId;
        _conversation!.desc = currentMessage.answer;
        _conversation!.remoteId = chat.topicId;
        notifyListeners();
      }
    } else if (pbMsg.id == 10003) {
      debugPrint('bot answer response');
      var chat = PBChat.fromBuffer(pbMsg.dataBytes);
      if (_conversation != null) {
        var currentMessage = messages[messages.length - 1];
        currentMessage.answer = chat.message;
        currentMessage.conversationRemoteId = chat.topicId;
        _conversation!.desc = currentMessage.answer;
        _conversation!.remoteId = chat.topicId;
        AppDatabase.instance.updateQAMessage(currentMessage);
        AppDatabase.instance.updateConversation(_conversation!);
        setCurrentState(ChatState.typeNext, notify: false);
        notifyListeners();
      }
    } else if (pbMsg.id == 10006) {
      debugPrint("check daily limit response");
      var limit = PBDailyLimit.fromBuffer(pbMsg.dataBytes);
      if (limit.isLimited) {
        if (_pendingSendMessageCallback != null) {
          _pendingSendMessageCallback!.complete(false);
        }
        setCurrentState(ChatState.typeNext);
      } else {
        sendPendingMessage().then((value) {
          if (_pendingSendMessageCallback != null) {
            _pendingSendMessageCallback!.complete(true);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    AppWebSocket.instance.unregisterEventListener(this);
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

  Future<bool> sendMessage(String text) {
    _pendingSendMessage = text;
    AppWebSocket.instance.checkLimit();
    _pendingSendMessageCallback = Completer<bool>();
    return _pendingSendMessageCallback!.future;
  }

  Future<void> sendPendingMessage() async {
    _conversation ??= await AppDatabase.instance.insertConversation(_pendingSendMessage, "", Conversation.typeQA);
    QAMessage message = await AppDatabase.instance.insertQAMessage(conv: _conversation!, question: _pendingSendMessage);
    messages.add(message);
    setCurrentState(ChatState.sending);
    AppWebSocket.instance.sendChat(_pendingSendMessage, _conversation!.remoteId);
  }

}