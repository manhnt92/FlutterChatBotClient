import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/utils/hexcolor.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends BaseStatefulScreen {

  ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
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
        List<Map<String, dynamic>> messages = [];
        for (var i = 0; i < datas.length; i++) {
          Map<String, dynamic> data = datas[i];
          String content;
          if (data['soket'] != null) {
            content = data['sender'] + '-' + data['content'] + '-' + data['soket'];
          } else {
            content = data['sender'] + '-' + data['content'];
          }
          Map<String, dynamic> msg = <String, dynamic>{};
          msg['message'] = Message(text: content);
          msg['isUserMessage'] = r.nextBool();
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
    var themeValue = MediaQuery.of(context).platformBrightness;
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
                      style: TextStyle(
                          color: themeValue == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: themeValue == Brightness.dark
                              ? Colors.white54
                              : Colors.black54,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        labelStyle: TextStyle(
                            color: themeValue == Brightness.dark
                                ? Colors.white
                                : Colors.black),
                        hintText: S.current.chat_send_message_hint,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: () {
                        sendMessage(messageController.text);
                        messageController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) async {
    // if (Utils.instance.currentLangCode == 'vi') {
    //   Utils.instance.setLangCode('en');
    // } else {
    //   Utils.instance.setLangCode('vi');
    // }
    // if (Utils.instance.currentThemeMode == 0) {
    //   Utils.instance.setThemeMode(1);
    // } else if (Utils.instance.currentThemeMode == 1) {
    //   Utils.instance.setThemeMode(2);
    // } else {
    //   Utils.instance.setThemeMode(0);
    // }
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    _socketListener.cancel();
  }

}

class ChatBody extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const ChatBody({
    Key? key,
    this.messages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        var obj = messages[messages.length - 1 - i];
        Message message = obj['message'];
        bool isUserMessage = obj['isUserMessage'] ?? false;
        return MessageContainer(
          message: message,
          isUserMessage: isUserMessage,
        );
      },
      separatorBuilder: (_, i) => Container(height: 10),
      itemCount: messages.length,
      reverse: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
    );
  }
}

class Message {
  String text;
  Message({required this.text});
}

class MessageContainer extends StatelessWidget {

  final Message message;
  final bool isUserMessage;

  const MessageContainer({
    Key? key,
    required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
        if (isUserMessage) {
          return Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.person),
                PlatformText(message.text)
              ],
            ),
          );
        } else {
          return Container(
            color: Colors.lightGreen,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation:false,
                totalRepeatCount: 0,
                animatedTexts: [
                  TyperAnimatedText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                ]
              ),
            )
          );
        }
      },
    );
  }
}