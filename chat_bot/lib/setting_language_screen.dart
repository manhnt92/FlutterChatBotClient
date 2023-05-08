import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';

class SettingLanguageScreen extends BaseStatelessScreen {

  const SettingLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.setting_language),
        leading: InkWell(
          onTap: goBack,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: Utils.supportedLocale.length,
          itemBuilder: (BuildContext context, int index) {
            String content = convertLocaleToString(Utils.supportedLocale[index]);
            bool isCurrentLang = Utils.supportedLocale[index].languageCode == Utils.instance.currentLangCode;
            return SizedBox(
              height: Utils.defaultListViewItemHeight,
              child: GestureDetector(
                onTap: () {
                  Utils.instance.setLangCode(Utils.supportedLocale[index].languageCode);
                },
                child: Row(
                  children: [
                    Expanded(child: Text(content, style: CustomStyle.body1)),
                    Visibility(visible: isCurrentLang, child: const Icon(Icons.done))
                  ],
                ),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1);
          },
      ),
    );
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