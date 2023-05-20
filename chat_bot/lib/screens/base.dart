import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/app_style.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {

  const BaseStatefulWidget({super.key});

  bool isInDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: AppStyle.body2))
    );
  }

}

abstract class BaseStatelessWidget extends StatelessWidget {

  const BaseStatelessWidget({super.key});

  bool isInDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> with WidgetsBindingObserver, RouteAware {

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message, style: AppStyle.body2))
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppNavigator.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
      WidgetsBinding.instance.addObserver(this);
    });
  }

  @override
  void dispose() {
    super.dispose();
    AppNavigator.routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint("didChangeAppLifecycleState state = $state");
  }

}