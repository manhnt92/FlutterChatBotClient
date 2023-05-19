import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/widgets/type_writer_text.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {

  final List<QAMessage> messages;

  const Chat({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
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
                            Expanded(child: TypeWriterText (
                                play: message.canPlayAnswerAnim,
                                text: Text(message.answer, style: CustomStyle.body2, softWrap: true),
                                maintainSize: false,
                                duration: const Duration(milliseconds: 16),
                                startCallback: () {
                                  message.canPlayAnswerAnim = false;
                                },
                              )
                            ),
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