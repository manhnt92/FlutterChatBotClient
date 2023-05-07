import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/main.dart';

abstract class BaseStatefulScreen extends StatefulWidget {

  const BaseStatefulScreen({super.key});

  MyAppState getRootState(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }

  bool isInDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

}

abstract class BaseStatelessScreen extends StatelessWidget {

  const BaseStatelessScreen({super.key});

  MyAppState getRootState(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }

  bool isInDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  void goBack() {
    Utils.instance.goBack();
  }

}