// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(value) => "(${value}% sale off)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "chat_send_message_hint":
            MessageLookupByLibrary.simpleMessage("Send a message..."),
        "chat_title": MessageLookupByLibrary.simpleMessage("Chat Bot"),
        "home_chat_history": MessageLookupByLibrary.simpleMessage("My history"),
        "home_suggestion": MessageLookupByLibrary.simpleMessage("Suggestions"),
        "home_title": MessageLookupByLibrary.simpleMessage("Home"),
        "premium_feature_1":
            MessageLookupByLibrary.simpleMessage("Unlimited chat"),
        "premium_feature_2": MessageLookupByLibrary.simpleMessage("No ads"),
        "premium_month": MessageLookupByLibrary.simpleMessage("Monthly"),
        "premium_month_price":
            MessageLookupByLibrary.simpleMessage("10 USD / month"),
        "premium_promotion": m0,
        "premium_purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "premium_purchase_term": MessageLookupByLibrary.simpleMessage(
            "By clicking \'Purchase\', you agree to our Terms. The amount will be charged, and the subscription will be extended for the selected period of time and at the same price until you cancel it int the Google Play settings.\n\nIt\'s not unlimited access. Plan is purposed for personal use. If you exceed the quota your account access may be limited or requests frequency decreased."),
        "premium_title": MessageLookupByLibrary.simpleMessage("Premium"),
        "premium_title_hint":
            MessageLookupByLibrary.simpleMessage("GO PREMIUM"),
        "premium_title_hint_1": MessageLookupByLibrary.simpleMessage(
            "You will get full access to our chatbot with high limits. Cancel anytime"),
        "premium_week": MessageLookupByLibrary.simpleMessage("Weekly"),
        "premium_week_price":
            MessageLookupByLibrary.simpleMessage("2 USD / week"),
        "setting_clear_history":
            MessageLookupByLibrary.simpleMessage("Clear all Chats and History"),
        "setting_contact_us":
            MessageLookupByLibrary.simpleMessage("Contact Us"),
        "setting_language": MessageLookupByLibrary.simpleMessage("Language"),
        "setting_language_en": MessageLookupByLibrary.simpleMessage("English"),
        "setting_language_vi":
            MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
        "setting_night_mode":
            MessageLookupByLibrary.simpleMessage("Night mode"),
        "setting_policy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "setting_restore_purchase":
            MessageLookupByLibrary.simpleMessage("Restore purchases"),
        "setting_share_app": MessageLookupByLibrary.simpleMessage("Share App"),
        "setting_subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
        "setting_subscribe_hint":
            MessageLookupByLibrary.simpleMessage("Get Full Access to Chat"),
        "setting_term": MessageLookupByLibrary.simpleMessage("Terms of use"),
        "setting_title": MessageLookupByLibrary.simpleMessage("Setting")
      };
}
