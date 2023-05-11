import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/home_vm.dart';
import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/widgets/list_view_item.dart';
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
    var viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(S.current.chat_history_title),
        leading: InkWell(
          onTap : () { CustomNavigator.goBack(); },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.separated(
            itemCount: viewModel.conversations.length,
            itemBuilder: (BuildContext context, int index) {
              var conv = viewModel.conversations[index];
              return InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {},
                child: Container(//height: Utils.conversationItemHeight,
                    decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, false)),
                        color: CustomStyle.colorBgElevatedButton(context, false),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () => _showConversationOptionSheet(context, conv),
                                customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Icon(Icons.more_horiz_outlined),
                                )
                            )
                          ],
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

  void _showConversationOptionSheet(BuildContext context, Conversation conv) {
    TextEditingController renameController = TextEditingController();
    FocusNode focusNode = FocusNode();
    showModalBottomSheet<void>(context: context, isScrollControlled: true, builder: (BuildContext ctx) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 30),
            TextFormField(
              focusNode: focusNode,
              controller: renameController,
              decoration: InputDecoration(border: InputBorder.none,
                  hintStyle: CustomStyle.body2I,
                  labelStyle: CustomStyle.body2,
                  hintText: conv.title,
                  counter: const Offstage(),
                  contentPadding: const EdgeInsets.only(left: 15, right: 15)
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLength: Utils.chatMaxLength,
              maxLines: 1,
            ),
            SimpleListViewItem(
              onTap: () {
                if (renameController.text.isNotEmpty) {
                  context.read<HomeViewModel>().updateConversation(conv, renameController.text);
                  Navigator.pop(ctx);
                } else {
                  focusNode.requestFocus();
                }
              },
              content: S.current.home_conversation_rename,
              leftWidget: const Icon(Icons.edit),
            ),
            const Divider(height: 1),
            SimpleListViewItem(
              onTap: () {
                context.read<HomeViewModel>().deleteConversation(conv);
                renameController.dispose();
                Navigator.pop(ctx);
              },
              content: S.current.home_conversation_delete,
              leftWidget: const Icon(Icons.delete),
            ),
            Container(height: 30)
          ],
        ),
      );
    },
    );
  }

}