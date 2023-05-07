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

  /// `Flutter Demo Home Page`
  String get home_title {
    return Intl.message(
      'Flutter Demo Home Page',
      name: 'home_title',
      desc: '',
      args: [],
    );
  }

  /// `You have pushed the button this many times:`
  String get home_push {
    return Intl.message(
      'You have pushed the button this many times:',
      name: 'home_push',
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
