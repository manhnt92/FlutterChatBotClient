import 'package:chat_bot/main_view_model.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/models/user.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/widgets/chat.dart';
import 'package:chat_bot/widgets/expandable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/screens/base.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text(""),
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
          AppNavigator.goToPremiumScreen(User.instance.freeMessageLeft == 0);
        });
      }
    });
    return future;
  }

}

