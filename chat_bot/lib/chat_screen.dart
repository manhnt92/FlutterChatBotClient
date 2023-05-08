import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends BaseStatefulWidget {

  ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController messageController = TextEditingController();
  List<Message> messages = [];
  late StreamSubscription<dynamic> _socketListener;
  String _accessToken = "";

  @override
  void initState() {
    super.initState();
    _socketListener = Utils.instance.getWebSocketStream().listen((event) {
      Map<String, dynamic> map = jsonDecode(event);
      if (map['id'] == 'loginResponse') {
        _accessToken = map['data']['longlivetoken'];
        debugPrint("access token = $_accessToken");

        Map<String, dynamic> rqMap = <String, dynamic>{};
        rqMap['id'] = 'joinpublicchatnew';
        rqMap['token'] = _accessToken;
        Utils.instance.sendSocketMessage(rqMap);
      } else if (map['id'] == 'chatHistoryNew') {
        List<dynamic> datas = map['dataParent'];
        Random r = Random();
        List<Message> messages = [];
        for (var i = 0; i < datas.length; i++) {
          Map<String, dynamic> data = datas[i];
          String content;
          if (data['soket'] != null) {
            content = data['sender'] + '-' + data['content'] + '-' + data['soket'];
          } else {
            content = data['sender'] + '-' + data['content'];
          }
          Message msg = Message();
          msg.text = content;
          msg.isFromUser = r.nextBool();
          messages.add(msg);
        }
        setState(() {
          this.messages.addAll(messages);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.chat_title),
        actions: [
          IconButton(onPressed: () {
            Utils.instance.goToSettingScreen();
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ChatBody(messages: messages)),
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: CustomStyle.body1I,
                        labelStyle: CustomStyle.body1,
                        hintText: S.current.chat_send_message_hint,
                      ),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        Message msg = Message();
        msg.text = messageController.text;
        msg.isFromUser = true;
        messages.add(msg);
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          Message msg = Message();
          msg.isFromUser = false;
          msg.isAnimated = false;
          messages.add(msg);
        });
      });
    }
    messageController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    _socketListener.cancel();
  }

}

class ChatBody extends StatelessWidget {

  final List<Message> messages;

  const ChatBody({Key? key, this.messages = const [] }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated (
      itemBuilder: (context, i) {
        var msg = messages[messages.length - 1 - i];
        return MessageContainer(message: msg);
      },
      separatorBuilder: (_, i) => Container(height: 5),
      itemCount: messages.length,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 15),
    );
  }
}

class Message {

  String text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  bool isFromUser = false;
  bool isAnimated = false;

}

class MessageContainer extends StatelessWidget {

  final Message message;

  MessageContainer({ Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
        if (message.isFromUser) {
          return Container(
            color: CustomStyle.colorLikeButtonBg(context, false),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    const Icon(Icons.person),
                    const SizedBox(width: 5),
                    Flexible(child: Text(message.text, style: CustomStyle.body1B, softWrap: true)),
                    const SizedBox(width: 15)
                  ],
                ),
                const SizedBox(height: 15)
              ],
            ),
          );
        } else {
          return Container(
            color: CustomStyle.colorLikeButtonBg(context, true),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    const SizedBox(width: 15),
                    Expanded(child: message.isAnimated ? Flexible(child: Text(message.text, style: CustomStyle.body1, softWrap: true)) : AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation:false,
                      totalRepeatCount: 0,
                      animatedTexts: [
                        TyperAnimatedText(message.text, textStyle: CustomStyle.body1)
                      ],
                      onFinished: () {
                        message.isAnimated = true;
                      },
                    )),
                    const SizedBox(width: 15)
                  ],
                ),
                const SizedBox(height: 15)
              ],
            )
          );
        }
      },
    );
  }
}