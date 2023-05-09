import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/chat_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseStatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.home_title),
        actions: [
          IconButton(onPressed: () {
            Utils.instance.goToSettingScreen();
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Text('home')),
            GestureDetector(
              onTap: goToChatScreen,
              child: ExpandableTextField(sendMessageCallback: (text) {}, enable: false)
            )
          ],
        ),
      ),
    );
  }

  void goToChatScreen() {
    Utils.instance.goToChatScreen();
  }

}