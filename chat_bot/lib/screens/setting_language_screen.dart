import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/widgets/list_view_item.dart';
import 'package:flutter/material.dart';

class SettingLanguageScreen extends BaseStatefulWidget {

  const SettingLanguageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingLanguageState();

}

class _SettingLanguageState extends BaseState<SettingLanguageScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.setting_language),
        leading: InkWell(
          onTap: () { CustomNavigator.goBack(); },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.separated(
        itemCount: Utils.supportedLocale.length,
        itemBuilder: (BuildContext context, int index) {
          String content = convertLocaleToString(Utils.supportedLocale[index]);
          bool isCurrentLang = Utils.supportedLocale[index].languageCode == Utils.instance.currentLangCode;
          return SimpleListViewItem(
            onTap: () => updateLangMode(index),
            content: content,
            rightWidget: isCurrentLang ? const Icon(Icons.done) : null,
          );
        }, separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
      ),
    );
  }

  void updateLangMode(int index) {
    setState(() {
      Utils.instance.setLangCode(Utils.supportedLocale[index].languageCode);
    });
  }

  String convertLocaleToString(Locale locale) {
    if (locale.languageCode == 'en') {
      return S.current.setting_language_en;
    } else if (locale.languageCode == 'vi') {
      return S.current.setting_language_vi;
    }
    return "";
  }


}