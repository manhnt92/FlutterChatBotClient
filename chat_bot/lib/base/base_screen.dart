import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/main.dart';

abstract class BaseStatefulWidget extends StatefulWidget {

  const BaseStatefulWidget({super.key});

  MyAppState getRootState(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }

  bool isInDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

}

abstract class BaseStatelessWidget extends StatelessWidget {

  const BaseStatelessWidget({super.key});

  MyAppState getRootState(BuildContext context) {
    return context.findAncestorStateOfType<MyAppState>()!;
  }

  bool isInDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint("didChangeAppLifecycleState state = $state");
  }


}