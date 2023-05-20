import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/app_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/widgets/list_view_item.dart';
import 'package:flutter/material.dart';

class ConversationOptionSheet extends StatefulWidget {

  final Conversation conversation;
  final void Function(String) renameCallback;
  final VoidCallback deleteCallback;

  const ConversationOptionSheet({super.key, required this.conversation, required this.renameCallback, required this.deleteCallback});

  @override
  State<StatefulWidget> createState() => _ConversationOptionState();

  static void show({required BuildContext context, required Conversation conversation, required Function(String) rename, required VoidCallback delete}) {
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (BuildContext ctx) {
      return ConversationOptionSheet(conversation: conversation, renameCallback: rename, deleteCallback: delete);
    });
  }

}

class _ConversationOptionState extends State<ConversationOptionSheet> {

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _renameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _renameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 30),
          TextFormField(
            focusNode: _focusNode,
            controller: _renameController,
            decoration: InputDecoration(border: InputBorder.none,
                hintStyle: AppStyle.body2I,
                labelStyle: AppStyle.body2,
                hintText: widget.conversation.title,
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
              if (_renameController.text.isNotEmpty) {
                widget.renameCallback(_renameController.text);
                Navigator.pop(context);
              } else {
                _focusNode.requestFocus();
              }
            },
            content: S.current.home_conversation_rename,
            leftWidget: const Icon(Icons.edit),
          ),
          const Divider(height: 1),
          SimpleListViewItem(
            onTap: () {
              Navigator.pop(context);
              widget.deleteCallback();
            },
            content: S.current.home_conversation_delete,
            leftWidget: const Icon(Icons.delete),
          ),
          Container(height: 30)
        ],
      ),
    );
  }

}