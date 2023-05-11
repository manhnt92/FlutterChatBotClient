import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/widgets/list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingScreen extends BaseStatelessWidget {

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
  bool _isNightMode = false;

  SettingScreen({super.key}) {
    _isNightMode = Utils.instance.currentThemeMode == ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.setting_title),
          leading: InkWell(
            onTap: () { CustomNavigator.goBack(); },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: PlatformElevatedButton(
                onPressed: () { CustomNavigator.goToPremiumScreen();} ,
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
                    onTap: () => updateNightMode(!_isNightMode),
                    content: _settings[index],
                    leftWidget: Icon(_settingIcons[index]),
                    rightWidget: index == 0 ? PlatformSwitch(value: _isNightMode, onChanged: (value) {
                      updateNightMode(value);
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

  void updateNightMode(bool value) {
    _isNightMode = value;
    Utils.instance.setThemeMode(_isNightMode ? ThemeMode.dark : ThemeMode.light);
  }

  void onSettingItemClicked(int index) {
    if (index == 1) {
      CustomNavigator.goToSettingLanguageScreen();
    } else if (index == 2) { // contact us

    } else if (index == 3) { // share app

    } else if (index == 4) { // restore purchase

    } else if (index == 5) { // privacy
      CustomNavigator.goToPrivacy();
    } else if (index == 6) { // term
      CustomNavigator.goToTerm();
    } else if (index == 7) { // clear chat history

    }
  }

}
