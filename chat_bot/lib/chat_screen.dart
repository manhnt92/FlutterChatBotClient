// import 'dart:async';
// import 'dart:math';
// import 'dart:convert';
// import 'package:chat_bot/models/qa_message.dart';
// import 'package:chat_bot/utils/expandable_text_field.dart';
// import 'package:chat_bot/utils/lv_chat_message_item.dart';
// import 'package:flutter/material.dart';
// import 'package:chat_bot/base/base_screen.dart';
// import 'package:chat_bot/utils/utils.dart';
// import 'package:chat_bot/generated/l10n.dart';
//
// class ChatScreen extends BaseStatefulWidget {
//
//   const ChatScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _ChatScreenState();
//
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//
//   List<ChatMessage> messages = [];
//   late StreamSubscription<dynamic> _socketListener;
//   String _accessToken = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _socketListener = Utils.instance.getWebSocketStream().listen((event) {
//       Map<String, dynamic> map = jsonDecode(event);
//       if (map['id'] == 'loginResponse') {
//         _accessToken = map['data']['longlivetoken'];
//         debugPrint("access token = $_accessToken");
//
//         Map<String, dynamic> rqMap = <String, dynamic>{};
//         rqMap['id'] = 'joinpublicchatnew';
//         rqMap['token'] = _accessToken;
//         Utils.instance.sendSocketMessage(rqMap);
//       } else if (map['id'] == 'chatHistoryNew') {
//         List<dynamic> datas = map['dataParent'];
//         Random r = Random();
//         List<ChatMessage> messages = [];
//         for (var i = 0; i < datas.length; i++) {
//           Map<String, dynamic> data = datas[i];
//           String content;
//           if (data['soket'] != null) {
//             content = data['sender'] + '-' + data['content'] + '-' + data['soket'];
//           } else {
//             content = data['sender'] + '-' + data['content'];
//           }
//           ChatMessage msg = ChatMessage();
//           msg.text = content;
//           msg.isFromUser = r.nextBool();
//           msg.isAnimated = false;
//           messages.add(msg);
//         }
//         setState(() {
//           this.messages.addAll(messages);
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(S.current.chat_title),
//         leading: InkWell(
//           onTap: widget.goBack,
//           child: const Icon(Icons.arrow_back),
//         ),
//         actions: [
//           IconButton(onPressed: () {
//             Utils.instance.goToSettingScreen();
//           }, icon: const Icon(Icons.settings))
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(child: ListView.separated (itemCount: messages.length,
//               reverse: true,
//               padding: const EdgeInsets.symmetric(vertical: 15),
//               itemBuilder: (context, i) {
//                   var msg = messages[messages.length - 1 - i];
//                   return LvChatMessageItem(message: msg);
//                 }, separatorBuilder: (_, i) => Container(height: 5),
//               )
//             ),
//             ExpandableTextField(sendMessageCallback: (text) => sendMessage(text), enable: true),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void sendMessage(String text) {
//     if (text.isNotEmpty) {
//       setState(() {
//         ChatMessage msg = ChatMessage();
//         msg.text = text;
//         msg.isFromUser = true;
//         messages.add(msg);
//       });
//       Future.delayed(const Duration(seconds: 1), () {
//         setState(() {
//           ChatMessage msg = ChatMessage();
//           msg.isFromUser = false;
//           msg.isAnimated = true;
//           messages.add(msg);
//         });
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _socketListener.cancel();
//   }
//
// }
//
