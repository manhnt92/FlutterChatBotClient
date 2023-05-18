import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/home_vm.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/widgets/conversation_option_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationsScreen extends BaseStatefulWidget {

  const ConversationsScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_ConversationsState();

}

class _ConversationsState extends BaseState<ConversationsScreen> {

  @override
  void initState() {
    super.initState();
    var viewModel = context.read<HomeViewModel>();
    viewModel.getAllConversation();
  }

  @override
  Widget build(BuildContext context) {
    var conversations = context.watch<HomeViewModel>().conversations;
    return Scaffold(
      appBar: AppBar(title: Text(S.current.chat_history_title),
        leading: InkWell(
          onTap : () { AppNavigator.goBack(); },
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.separated(
            itemCount: conversations.length,
            itemBuilder: (BuildContext context, int index) {
              var conv = conversations[index];
              return InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () { AppNavigator.goToChatScreen(conv); },
                child: Container(//height: Utils.conversationItemHeight,
                    decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, false)),
                        color: CustomStyle.colorBgElevatedButton(context, false),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => _showConversationOption(conv),
                              customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Icon(Icons.more_horiz_outlined),
                              )
                            )
                          ]
                        ),
                        Container(height: 5),
                        Container(
                          padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                          child: Column(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(conv.title, style: CustomStyle.body2B),
                                Text(conv.desc, style: CustomStyle.body2, maxLines: 5, overflow: TextOverflow.ellipsis),
                              ]
                          ),
                        ),
                      ],
                    )
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 10);
            }
          ),
        ),
      ),
    );
  }

  void _showConversationOption(Conversation conv) {
    ConversationOptionSheet.show(context: context, conversation: conv,
      rename: (newName) {
        context.read<HomeViewModel>().updateConversation(conv, newName);
      },
      delete: () {
        context.read<HomeViewModel>().deleteConversation(conv);
      }
    );
  }

}