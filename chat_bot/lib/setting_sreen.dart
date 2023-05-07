import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingScreen extends BaseStatelessScreen {

  List<String> entries = <String>[ S.current.setting_night_mode, S.current.setting_language,
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
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: PlatformElevatedButton(
                    material: (BuildContext context, PlatformTarget target) {
                      return MaterialElevatedButtonData(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black87,
                          primary: Colors.grey[300],
                          minimumSize: Size(88, 36),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ));
                    },
                    cupertino: (BuildContext context, PlatformTarget target) {
                      return CupertinoElevatedButtonData();
                    },
                    onPressed: () {
                      Utils.instance.goToPremiumScreen();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        PlatformText(S.current.setting_subscribe, style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22
                        )),
                        PlatformText(S.current.setting_subscribe_hint),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(itemCount: entries.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SizedBox(height: Utils.defaultListViewItemHeight,
                      child: Row(
                        children: [
                          Expanded(child: PlatformText(entries[index], style: const TextStyle(fontWeight: FontWeight.w700))),
                          PlatformSwitch(value: _isNightMode, onChanged: (value) {
                            _isNightMode = value;
                            Utils.instance.setThemeMode(_isNightMode ? ThemeMode.dark : ThemeMode.light);
                          })
                        ],
                      )
                  );
                }
                return SizedBox(height: Utils.defaultListViewItemHeight,
                  child: GestureDetector(
                    onTap: () => onSettingItemClicked(index),
                    child: Row(
                      children: [
                        Expanded(child: PlatformText(entries[index], style: const TextStyle(fontWeight: FontWeight.w700))),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                );
            }, separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1);
            }),
          ),
        ],
      )
    );
  }

  void onSettingItemClicked(int index) {
    if (index == 1) {
      Utils.instance.goToSettingLanguageScreen();
    }
  }

}
