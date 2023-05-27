import 'dart:ffi';

import 'package:chat_bot/main_view_model.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/widgets/chat.dart';
import 'package:chat_bot/widgets/expandable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:provider/provider.dart';

class ChatScreen extends BaseStatefulWidget {

  final Conversation? conversation;

  const ChatScreen({super.key, this.conversation});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ChatViewModel>().getAllMessage(widget.conversation);
  }

  @override
  Widget build(BuildContext context) {
    var chatVm = context.watch<ChatViewModel>();
    var mainVm = context.watch<MainViewModel>();
    String chatTitle;
    if (mainVm.isPurchased) {
      chatTitle = S.current.chat_title;
    } else if (mainVm.freeMessageLeft == 1) {
      chatTitle = S.current.free_chat_title_1;
    } else if (mainVm.freeMessageLeft == 0) {
      chatTitle = S.current.free_chat_title_0;
    } else {
      chatTitle = S.current.free_chat_title(mainVm.freeMessageLeft);
    }
    return Scaffold(
      appBar: AppBar(title: Text(chatTitle),
        leading: InkWell(
          onTap: () {
            context.read<ChatViewModel>().setCurrentState(ChatState.disable);
            AppNavigator.goBack();
          },
          child: const Icon(Icons.arrow_back),
        )
      ),
      body: SafeArea(
        child: Column(
          children: [
            Chat(messages: chatVm.messages, currentState: chatVm.currentState),
            ExpandableTextField(sendMessageCallback: (text) => sendMessage(text))
          ],
        ),
      ),
    );
  }

  Future<bool> sendMessage(String text) {
    var future = context.read<ChatViewModel>().sendMessage(text);
    future.then((success) {
      if (!success) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AppNavigator.goToPremiumScreen(true);
        });
      }
    });
    return future;
  }

}

