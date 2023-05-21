import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/utils/app_style.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {

  List<QAMessage> messages;
  ChatState currentState;

  Chat({super.key, required this.messages, required this.currentState});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.currentState == ChatState.sending) {
      _scrollController.animateTo(0.0, curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300));
    }
    return Expanded(
      child: ListView.separated (itemCount: widget.messages.length,
        controller: _scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, i) {
          var message = widget.messages[widget.messages.length - 1 - i];
          return Column(
            children: [
              Container(
                color: AppStyle.colorBgElevatedButton(context, false),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                        children: [
                          const SizedBox(width: 15),
                          const Icon(Icons.person),
                          const SizedBox(width: 5),
                          Text('Me', style: AppStyle.body2B, softWrap: true)
                        ]
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Flexible(child: Text(message.question, style: AppStyle.body2, softWrap: true)),
                        const SizedBox(width: 15)
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
              Visibility(
                visible: message.answer.isNotEmpty,
                child: Container(
                    color: AppStyle.colorBgElevatedButton(context, true),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                            children: [
                              const SizedBox(width: 15),
                              const Icon(Icons.computer),
                              const SizedBox(width: 5),
                              Text('Bot', style: AppStyle.body2B, softWrap: true)
                            ]
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            Expanded(child: Text(message.answer, style: AppStyle.body2, softWrap: true)),
                            const SizedBox(width: 15)
                          ],
                        ),
                        const SizedBox(height: 10)
                      ],
                    )
                ),
              )
            ],
          );
        }, separatorBuilder: (_, i) => Container(height: 0),
      ),
    );
  }
}