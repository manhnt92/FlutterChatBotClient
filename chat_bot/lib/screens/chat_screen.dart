import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:chat_bot/widgets/chat.dart';
import 'package:chat_bot/widgets/expandable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/base/base_screen.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(S.current.chat_title),
        leading: InkWell(
          onTap: () { CustomNavigator.goBack(); },
          child: const Icon(Icons.arrow_back),
        )
      ),
      body: SafeArea(
        child: Column(
          children: [
            Chat(messages: context.watch<ChatViewModel>().messages),
            ExpandableTextField(
              sendMessageCallback: (text) { context.read<ChatViewModel>().sendMessage(text); })
          ],
        ),
      ),
    );
  }

}

