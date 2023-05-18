import 'package:chat_bot/main_view_model.dart';
import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/widgets/list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class SettingScreen extends BaseStatefulWidget {

  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();

}

class _SettingScreenState extends BaseState<SettingScreen> {

  final List<IconData> _settingIcons = [
    Icons.nightlight,
    Icons.language,
    Icons.support_agent,
    Icons.share,
    Icons.reset_tv,
    Icons.privacy_tip,
    Icons.privacy_tip,
    Icons.delete_forever
  ];
  final List<String> _settings = [ S.current.setting_night_mode, S.current.setting_language,
    S.current.setting_contact_us, S.current.setting_share_app, S.current.setting_restore_purchase,
    S.current.setting_policy, S.current.setting_term, S.current.setting_clear_history
  ];

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<MainViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.setting_title),
          leading: InkWell(
            onTap: () { AppNavigator.goBack(); },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: PlatformElevatedButton(
                onPressed: () { AppNavigator.goToPremiumScreen();} ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(S.current.setting_subscribe, style: CustomStyle.body1B),
                    Text(S.current.setting_subscribe_hint, style: CustomStyle.body2),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.separated(
                    itemCount: _settings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SimpleListViewItem(
                        onTap: () => onSettingItemClicked(index),
                        content: _settings[index],
                        leftWidget: Icon(_settingIcons[index]),
                        rightWidget: index == 0 ? PlatformSwitch(value: viewModel.currentThemeMode == ThemeMode.dark, onChanged: (value) {
                          _updateNightMode(value);
                        }) : const Icon(Icons.chevron_right),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 1);
                })
            ),
          ],
        )
    );
  }

  void _updateNightMode(bool value) {
    context.read<MainViewModel>().setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void onSettingItemClicked(int index) {
    if (index == 0) {
      bool isNightMode = context.read<MainViewModel>().currentThemeMode == ThemeMode.dark;
      _updateNightMode(!isNightMode);
    } else if (index == 1) {
      AppNavigator.goToSettingLanguageScreen();
    } else if (index == 2) { // contact us

    } else if (index == 3) { // share app

    } else if (index == 4) { // restore purchase

    } else if (index == 5) { // privacy
      AppNavigator.goToPrivacy();
    } else if (index == 6) { // term
      AppNavigator.goToTerm();
    } else if (index == 7) { // clear chat history

    }
  }

}
