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

  static String m0(value) => "Free ${value} Messages";

  static String m1(value) => "(Save ${value}%)";

  static String m2(value) =>
      "By clicking \'${value}\', you agree to our Terms. The amount will be charged, and the subscription will be extended for the selected period of time and at the same price until you cancel it int the Google Play settings.\n\nIt\'s not unlimited access. Plan is purposed for personal use. If you exceed the quota your account access may be limited or requests frequency decreased.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "button_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "button_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "chat_history_title": MessageLookupByLibrary.simpleMessage("History"),
        "chat_next_question":
            MessageLookupByLibrary.simpleMessage("Next Question"),
        "chat_send_message_hint":
            MessageLookupByLibrary.simpleMessage("Send a message..."),
        "chat_title": MessageLookupByLibrary.simpleMessage("VegaAI Premium"),
        "chat_wait_response": MessageLookupByLibrary.simpleMessage(
            "Please wait for bot response before asking the next question..."),
        "free_chat_title": m0,
        "free_chat_title_0":
            MessageLookupByLibrary.simpleMessage("Free 0 Message"),
        "free_chat_title_1":
            MessageLookupByLibrary.simpleMessage("Free 1 Message"),
        "home_conversation_delete":
            MessageLookupByLibrary.simpleMessage("Delete"),
        "home_conversation_empty":
            MessageLookupByLibrary.simpleMessage("No history found."),
        "home_conversation_history":
            MessageLookupByLibrary.simpleMessage("My history"),
        "home_conversation_rename":
            MessageLookupByLibrary.simpleMessage("Rename"),
        "home_conversation_rename_cancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "home_conversation_view_all":
            MessageLookupByLibrary.simpleMessage("View all"),
        "home_suggestion": MessageLookupByLibrary.simpleMessage("Suggestions"),
        "home_title": MessageLookupByLibrary.simpleMessage("Home"),
        "premium_ads": MessageLookupByLibrary.simpleMessage("Reward Ads"),
        "premium_ads_price": MessageLookupByLibrary.simpleMessage(
            "Watch ads to get 1 free chat"),
        "premium_feature_1":
            MessageLookupByLibrary.simpleMessage("Powered by GPT4"),
        "premium_feature_1_desc":
            MessageLookupByLibrary.simpleMessage("Latest ChatGPT AI model"),
        "premium_feature_2":
            MessageLookupByLibrary.simpleMessage("Higher Word Limit"),
        "premium_feature_2_desc":
            MessageLookupByLibrary.simpleMessage("Type longer messages"),
        "premium_feature_3": MessageLookupByLibrary.simpleMessage("No Limits"),
        "premium_feature_3_desc":
            MessageLookupByLibrary.simpleMessage("Have unlimited dialogues"),
        "premium_feature_4": MessageLookupByLibrary.simpleMessage("No Ads"),
        "premium_feature_4_desc":
            MessageLookupByLibrary.simpleMessage("Enjoy app without ads"),
        "premium_promotion": m1,
        "premium_purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "premium_purchase_ads":
            MessageLookupByLibrary.simpleMessage("Watch ads"),
        "premium_purchase_term": m2,
        "premium_purchase_try_for_free":
            MessageLookupByLibrary.simpleMessage("Try for free"),
        "premium_title": MessageLookupByLibrary.simpleMessage("Premium"),
        "premium_title_hint":
            MessageLookupByLibrary.simpleMessage("GO PREMIUM"),
        "premium_title_hint_1": MessageLookupByLibrary.simpleMessage(
            "You will get full access to our chatbot with high limits. Cancel anytime"),
        "premium_week": MessageLookupByLibrary.simpleMessage("Weekly"),
        "premium_year": MessageLookupByLibrary.simpleMessage("Yearly"),
        "question_remove_all_conversation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete all the data, chats and messages. You cannot undo this action"),
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
        "setting_title": MessageLookupByLibrary.simpleMessage("Setting"),
        "toast_no_internet_connection":
            MessageLookupByLibrary.simpleMessage("No Internet Connection"),
        "toast_remove_all_conversation_success":
            MessageLookupByLibrary.simpleMessage("The chats has been cleared"),
        "toast_remove_conversation_success":
            MessageLookupByLibrary.simpleMessage("Delete success"),
        "toast_rename_conversation_success":
            MessageLookupByLibrary.simpleMessage("Rename success")
      };
}
