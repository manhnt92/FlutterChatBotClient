
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/widgets/chat_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {

  Conversation? conversation;

  Chat({super.key, this.conversation});

  @override
  State<StatefulWidget> createState() => _ChatState();

}

class _ChatState extends State<Chat> {

  @override
  void initState() {
    super.initState();
    debugPrint("conversation  != null : ${widget.conversation != null}");
    var viewModel = context.read<ChatViewModel>();
    viewModel.conversation = widget.conversation;
    viewModel.getAllMessage();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ChatViewModel>();
    return Expanded(
      child: ListView.separated (itemCount: viewModel.messages.length,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, i) {
          var message = viewModel.messages[viewModel.messages.length - 1 - i];
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
                            Expanded(child: message.canPlayAnswerAnim ? AnimatedTextKit(
                              repeatForever: false,
                              isRepeatingAnimation:false,
                              totalRepeatCount: 0,
                              pause: const Duration(milliseconds: 200),
                              animatedTexts: [
                                TyperAnimatedText('', textStyle: CustomStyle.body2),
                                TyperAnimatedText(message.answer, textStyle: CustomStyle.body2)
                              ],
                              onNext: (index, isLast) {
                                debugPrint('onNext : $index, $isLast');
                                message.canPlayAnswerAnim = false;
                              },
                              onFinished: () {
                                debugPrint('onFinish');
                              },
                            ) : Text(message.answer, style: CustomStyle.body2, softWrap: true)
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