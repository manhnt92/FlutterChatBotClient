// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `No Internet Connection`
  String get toast_no_internet_connection {
    return Intl.message(
      'No Internet Connection',
      name: 'toast_no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Rename success`
  String get toast_rename_conversation_success {
    return Intl.message(
      'Rename success',
      name: 'toast_rename_conversation_success',
      desc: '',
      args: [],
    );
  }

  /// `Delete success`
  String get toast_remove_conversation_success {
    return Intl.message(
      'Delete success',
      name: 'toast_remove_conversation_success',
      desc: '',
      args: [],
    );
  }

  /// `The chats has been cleared`
  String get toast_remove_all_conversation_success {
    return Intl.message(
      'The chats has been cleared',
      name: 'toast_remove_all_conversation_success',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all the data, chats and messages. You cannot undo this action`
  String get question_remove_all_conversation {
    return Intl.message(
      'Are you sure you want to delete all the data, chats and messages. You cannot undo this action',
      name: 'question_remove_all_conversation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get button_cancel {
    return Intl.message(
      'Cancel',
      name: 'button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get button_delete {
    return Intl.message(
      'Delete',
      name: 'button_delete',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_title {
    return Intl.message(
      'Home',
      name: 'home_title',
      desc: '',
      args: [],
    );
  }

  /// `My history`
  String get home_conversation_history {
    return Intl.message(
      'My history',
      name: 'home_conversation_history',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get home_conversation_view_all {
    return Intl.message(
      'View all',
      name: 'home_conversation_view_all',
      desc: '',
      args: [],
    );
  }

  /// `No history found.`
  String get home_conversation_empty {
    return Intl.message(
      'No history found.',
      name: 'home_conversation_empty',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get home_conversation_rename {
    return Intl.message(
      'Rename',
      name: 'home_conversation_rename',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get home_conversation_rename_cancel {
    return Intl.message(
      'Cancel',
      name: 'home_conversation_rename_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get home_conversation_delete {
    return Intl.message(
      'Delete',
      name: 'home_conversation_delete',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions`
  String get home_suggestion {
    return Intl.message(
      'Suggestions',
      name: 'home_suggestion',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get chat_history_title {
    return Intl.message(
      'History',
      name: 'chat_history_title',
      desc: '',
      args: [],
    );
  }

  /// `Chat Bot`
  String get chat_title {
    return Intl.message(
      'Chat Bot',
      name: 'chat_title',
      desc: '',
      args: [],
    );
  }

  /// `Send a message...`
  String get chat_send_message_hint {
    return Intl.message(
      'Send a message...',
      name: 'chat_send_message_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please wait for bot response before asking the next question...`
  String get chat_wait_response {
    return Intl.message(
      'Please wait for bot response before asking the next question...',
      name: 'chat_wait_response',
      desc: '',
      args: [],
    );
  }

  /// `Next Question`
  String get chat_next_question {
    return Intl.message(
      'Next Question',
      name: 'chat_next_question',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting_title {
    return Intl.message(
      'Setting',
      name: 'setting_title',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get setting_subscribe {
    return Intl.message(
      'Subscribe',
      name: 'setting_subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Get Full Access to Chat`
  String get setting_subscribe_hint {
    return Intl.message(
      'Get Full Access to Chat',
      name: 'setting_subscribe_hint',
      desc: '',
      args: [],
    );
  }

  /// `Night mode`
  String get setting_night_mode {
    return Intl.message(
      'Night mode',
      name: 'setting_night_mode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get setting_language {
    return Intl.message(
      'Language',
      name: 'setting_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get setting_language_en {
    return Intl.message(
      'English',
      name: 'setting_language_en',
      desc: '',
      args: [],
    );
  }

  /// `Tiếng Việt`
  String get setting_language_vi {
    return Intl.message(
      'Tiếng Việt',
      name: 'setting_language_vi',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get setting_contact_us {
    return Intl.message(
      'Contact Us',
      name: 'setting_contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get setting_share_app {
    return Intl.message(
      'Share App',
      name: 'setting_share_app',
      desc: '',
      args: [],
    );
  }

  /// `Restore purchases`
  String get setting_restore_purchase {
    return Intl.message(
      'Restore purchases',
      name: 'setting_restore_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get setting_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'setting_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get setting_term {
    return Intl.message(
      'Terms of use',
      name: 'setting_term',
      desc: '',
      args: [],
    );
  }

  /// `Clear all Chats and History`
  String get setting_clear_history {
    return Intl.message(
      'Clear all Chats and History',
      name: 'setting_clear_history',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get premium_title {
    return Intl.message(
      'Premium',
      name: 'premium_title',
      desc: '',
      args: [],
    );
  }

  /// `GO PREMIUM`
  String get premium_title_hint {
    return Intl.message(
      'GO PREMIUM',
      name: 'premium_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `You will get full access to our chatbot with high limits. Cancel anytime`
  String get premium_title_hint_1 {
    return Intl.message(
      'You will get full access to our chatbot with high limits. Cancel anytime',
      name: 'premium_title_hint_1',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get premium_week {
    return Intl.message(
      'Weekly',
      name: 'premium_week',
      desc: '',
      args: [],
    );
  }

  /// `First 3 days free, then 2 USD / week`
  String get premium_week_price {
    return Intl.message(
      'First 3 days free, then 2 USD / week',
      name: 'premium_week_price',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get premium_month {
    return Intl.message(
      'Monthly',
      name: 'premium_month',
      desc: '',
      args: [],
    );
  }

  /// `10 USD / month, auto renewable`
  String get premium_month_price {
    return Intl.message(
      '10 USD / month, auto renewable',
      name: 'premium_month_price',
      desc: '',
      args: [],
    );
  }

  /// `Reward Ads`
  String get premium_ads {
    return Intl.message(
      'Reward Ads',
      name: 'premium_ads',
      desc: '',
      args: [],
    );
  }

  /// `Watch ads to get 1 free chat`
  String get premium_ads_price {
    return Intl.message(
      'Watch ads to get 1 free chat',
      name: 'premium_ads_price',
      desc: '',
      args: [],
    );
  }

  /// `(Save {value}%)`
  String premium_promotion(String value) {
    return Intl.message(
      '(Save $value%)',
      name: 'premium_promotion',
      desc: '',
      args: [value],
    );
  }

  /// `Powered by GPT4`
  String get premium_feature_1 {
    return Intl.message(
      'Powered by GPT4',
      name: 'premium_feature_1',
      desc: '',
      args: [],
    );
  }

  /// `Latest ChatGPT AI model`
  String get premium_feature_1_desc {
    return Intl.message(
      'Latest ChatGPT AI model',
      name: 'premium_feature_1_desc',
      desc: '',
      args: [],
    );
  }

  /// `Higher Word Limit`
  String get premium_feature_2 {
    return Intl.message(
      'Higher Word Limit',
      name: 'premium_feature_2',
      desc: '',
      args: [],
    );
  }

  /// `Type longer messages`
  String get premium_feature_2_desc {
    return Intl.message(
      'Type longer messages',
      name: 'premium_feature_2_desc',
      desc: '',
      args: [],
    );
  }

  /// `No Limits`
  String get premium_feature_3 {
    return Intl.message(
      'No Limits',
      name: 'premium_feature_3',
      desc: '',
      args: [],
    );
  }

  /// `Have unlimited dialogues`
  String get premium_feature_3_desc {
    return Intl.message(
      'Have unlimited dialogues',
      name: 'premium_feature_3_desc',
      desc: '',
      args: [],
    );
  }

  /// `No Ads`
  String get premium_feature_4 {
    return Intl.message(
      'No Ads',
      name: 'premium_feature_4',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy app without ads`
  String get premium_feature_4_desc {
    return Intl.message(
      'Enjoy app without ads',
      name: 'premium_feature_4_desc',
      desc: '',
      args: [],
    );
  }

  /// `Try for free`
  String get premium_purchase_try_for_free {
    return Intl.message(
      'Try for free',
      name: 'premium_purchase_try_for_free',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get premium_purchase {
    return Intl.message(
      'Purchase',
      name: 'premium_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Watch ads`
  String get premium_purchase_ads {
    return Intl.message(
      'Watch ads',
      name: 'premium_purchase_ads',
      desc: '',
      args: [],
    );
  }

  /// `By clicking '{value}', you agree to our Terms. The amount will be charged, and the subscription will be extended for the selected period of time and at the same price until you cancel it int the Google Play settings.\n\nIt's not unlimited access. Plan is purposed for personal use. If you exceed the quota your account access may be limited or requests frequency decreased.`
  String premium_purchase_term(String value) {
    return Intl.message(
      'By clicking \'$value\', you agree to our Terms. The amount will be charged, and the subscription will be extended for the selected period of time and at the same price until you cancel it int the Google Play settings.\n\nIt\'s not unlimited access. Plan is purposed for personal use. If you exceed the quota your account access may be limited or requests frequency decreased.',
      name: 'premium_purchase_term',
      desc: '',
      args: [value],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
