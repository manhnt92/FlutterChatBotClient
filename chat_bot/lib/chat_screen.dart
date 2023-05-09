import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends BaseStatefulWidget {

  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {

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
          msg.isAnimated = false;
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
        leading: InkWell(
          onTap: widget.goBack,
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: () {
            Utils.instance.goToSettingScreen();
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ListView.separated (itemCount: messages.length,
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (context, i) {
                  var msg = messages[messages.length - 1 - i];
                  return MessageContainer(message: msg);
                }, separatorBuilder: (_, i) => Container(height: 5),
              )
            ),
            ExpandableTextField(sendMessageCallback: (text) => sendMessage(text), enable: true),
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        Message msg = Message();
        msg.text = text;
        msg.isFromUser = true;
        messages.add(msg);
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          Message msg = Message();
          msg.isFromUser = false;
          msg.isAnimated = true;
          messages.add(msg);
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _socketListener.cancel();
  }

}

class Message {

  String text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  bool isFromUser = false;
  bool isAnimated = false;

}

class MessageContainer extends StatelessWidget {

  final Message message;

  const MessageContainer({ Key? key, required this.message}) : super(key: key);

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
                    Expanded(child: message.isAnimated ? AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation:false,
                      totalRepeatCount: 0,
                      pause: const Duration(milliseconds: 200),
                      animatedTexts: [
                        TyperAnimatedText(message.text, textStyle: CustomStyle.body1)
                      ],
                      onFinished: () {
                        message.isAnimated = false;
                      },
                    ) : Text(message.text, style: CustomStyle.body1, softWrap: true)
                    ),
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

class ExpandableTextField extends StatefulWidget {

  final VoidCallback? clickCallback;
  final void Function(String)? sendMessageCallback;
  final bool enable;

  const ExpandableTextField({Key? key, this.sendMessageCallback, this.clickCallback, required this.enable}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField>  {

  late double _height, _minHeight, _maxHeight;
  bool _swipeUp = true;
  int _heightAnimDuration = 0;
  final TextEditingController messageController = TextEditingController();
  String currentChatLength = "0/${Utils.chatMaxLength}";

  @override
  void initState() {
    super.initState();
    _minHeight = 50;
    _maxHeight = 270;
    _height = _minHeight;
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.clickCallback,
      onPanUpdate: (details) => widget.enable ? handlePanUpdate(isEnd: false, dy: details.delta.dy) : null,
      onPanEnd: (details) => widget.enable ? handlePanUpdate(isEnd: true) : null,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: CustomStyle.colorTextField(context)),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: CustomStyle.colorTextField(context)
        ),
        child: Column(
          children: <Widget>[
            Container(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AnimatedContainer(
                constraints: BoxConstraints(minHeight: _height),
                duration: Duration(milliseconds: _heightAnimDuration),
                child: TextFormField(
                    enabled: widget.enable,
                    controller: messageController,
                    decoration: InputDecoration(border: InputBorder.none,
                      hintStyle: CustomStyle.body2I,
                      labelStyle: CustomStyle.body2,
                      hintText: S.current.chat_send_message_hint,
                      counter: const Offstage(),
                      // constraints: /*_swipeUp ?*/ BoxConstraints(minHeight: _height) /*: BoxConstraints(minHeight: _height, maxHeight: _height)*/,
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    onChanged: (text) => onMessageChanged(text),
                    maxLength: Utils.chatMaxLength,
                    minLines: 1,
                    maxLines: 10
                ),
              ),
            ),
            const Divider(height: 1),
            SizedBox(height: 45,
                child: Row(
                  children: [
                    Container(width: 5),
                    Visibility(visible: messageController.text.isNotEmpty, child: IconButton(icon: const Icon(Icons.clear), onPressed: clearMessage)),
                    const Spacer(),
                    Text(currentChatLength, style: CustomStyle.caption),
                    Container(width: 5),
                    IconButton(onPressed: widget.enable ? sendMessage : null, icon: Icon(Icons.send_rounded, color: CustomStyle.bgColorButton(context))),
                    Container(width: 5)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  void handlePanUpdate({required bool isEnd, double dy = 0}) {
    if (isEnd) {
      setState(() {
        _heightAnimDuration = 200;
        double distance = _maxHeight - _minHeight;
        if (_swipeUp) {
          _height = _height > (_minHeight + 0.3 * distance) ? _maxHeight : _minHeight;
        } else {
          _height = _height < (_maxHeight - 0.3 * distance) ? _minHeight : _maxHeight;
        }
      });
    } else {
      _swipeUp = dy <= 0;
      setState(() {
        _heightAnimDuration = 0;
        _height -= dy;
        if (_height > _maxHeight) {
          _height = _maxHeight;
        } else if (_height < _minHeight) {
          _height = _minHeight;
        }
      });
    }
  }

  void clearMessage() {
    messageController.clear();
    setState(() {
      currentChatLength = "0/${Utils.chatMaxLength}";
    });
  }

  void onMessageChanged(String text) {
    setState(() {
      currentChatLength = "${text.length}/${Utils.chatMaxLength}";
      final numLines = '\n'.allMatches(text).length + 1;
      debugPrint('current line count = $numLines');
    });
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      if (widget.sendMessageCallback != null) {
        widget.sendMessageCallback!(messageController.text);
      }
    }
    clearMessage();
  }

}