import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/utils.dart';
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
            onTap: goBack,
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
              child: ListView.separated(itemCount: _settings.length,
                  itemBuilder: (BuildContext context, int index) {
                    return uiForSettingItem(context, index);
                  }, separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 1);
                  }),
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

  Widget uiForSettingItem(BuildContext context, int index) {
    if (index == 0) {
      return SizedBox(height: Utils.defaultListViewItemHeight,
          child: InkWell(
            onTap: () {
              updateNightMode(!_isNightMode);
            },
            child: Row(
              children: [
                const SizedBox(width: 15),
                Icon(_settingIcons[index]),
                const SizedBox(width: 15),
                Expanded(child: Text(_settings[index], style: CustomStyle.body2)),
                PlatformSwitch(value: _isNightMode, onChanged: (value) {
                  updateNightMode(value);
                }),
                const SizedBox(width: 15)
              ],
            ),
          )
      );
    }
    return SizedBox(height: Utils.defaultListViewItemHeight,
      child: InkWell(
        onTap: () => onSettingItemClicked(index),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Icon(_settingIcons[index]),
            const SizedBox(width: 15),
            Expanded(child: Text(_settings[index], style: CustomStyle.body2)),
            const Icon(Icons.chevron_right),
            const SizedBox(width: 15)
          ],
        ),
      ),
    );
  }

}
