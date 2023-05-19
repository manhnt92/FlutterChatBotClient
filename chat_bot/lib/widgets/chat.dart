import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {

  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
    var messages = context.watch<ChatViewModel>().messages;
    return Expanded(
      child: ListView.separated (itemCount: messages.length,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, i) {
          var message = messages[messages.length - 1 - i];
          return Column(
            children: [
              Container(
                color: CustomStyle.colorBgElevatedButton(context, false),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                        children: [
                          const SizedBox(width: 15),
                          const Icon(Icons.person),
                          const SizedBox(width: 5),
                          Text('Me', style: CustomStyle.body2B, softWrap: true)
                        ]
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Flexible(child: Text(message.question, style: CustomStyle.body2, softWrap: true)),
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
                    color: CustomStyle.colorBgElevatedButton(context, true),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                            children: [
                              const SizedBox(width: 15),
                              const Icon(Icons.computer),
                              const SizedBox(width: 5),
                              Text('Bot', style: CustomStyle.body2B, softWrap: true)
                            ]
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            Expanded(child: Text(message.answer, style: CustomStyle.body2, softWrap: true)),
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