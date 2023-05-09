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

  /// `Home`
  String get home_title {
    return Intl.message(
      'Home',
      name: 'home_title',
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

  /// `2 USD / week`
  String get premium_week_price {
    return Intl.message(
      '2 USD / week',
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

  /// `10 USD / month`
  String get premium_month_price {
    return Intl.message(
      '10 USD / month',
      name: 'premium_month_price',
      desc: '',
      args: [],
    );
  }

  /// `({value}% sale off)`
  String premium_promotion(String value) {
    return Intl.message(
      '($value% sale off)',
      name: 'premium_promotion',
      desc: '',
      args: [value],
    );
  }

  /// `Unlimited chat`
  String get premium_feature_1 {
    return Intl.message(
      'Unlimited chat',
      name: 'premium_feature_1',
      desc: '',
      args: [],
    );
  }

  /// `No ads`
  String get premium_feature_2 {
    return Intl.message(
      'No ads',
      name: 'premium_feature_2',
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

  /// `By clicking 'Purchase', you agree to our Terms. The amount will be charged, and the subscription will be extended for the selected period of time and at the same price until you cancel it int the Google Play settings.\n\nIt's not unlimited access. Plan is purposed for personal use. If you exceed the quota your account access may be limited or requests frequency decreased.`
  String get premium_purchase_term {
    return Intl.message(
      'By clicking \'Purchase\', you agree to our Terms. The amount will be charged, and the subscription will be extended for the selected period of time and at the same price until you cancel it int the Google Play settings.\n\nIt\'s not unlimited access. Plan is purposed for personal use. If you exceed the quota your account access may be limited or requests frequency decreased.',
      name: 'premium_purchase_term',
      desc: '',
      args: [],
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
