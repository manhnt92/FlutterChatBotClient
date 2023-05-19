import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandableTextField extends StatefulWidget {

  final VoidCallback? clickCallback;
  final void Function(String)? sendMessageCallback;
  final VoidCallback? newConversationCallback;
  String? suggestContent;

  ExpandableTextField({super.key, this.sendMessageCallback, this.clickCallback, this.newConversationCallback, this.suggestContent});

  @override
  State<StatefulWidget> createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField>  {

  late double _height, _minHeight, _maxHeight;
  bool _swipeUp = true;
  int _heightAnimDuration = 0;
  final TextEditingController _messageController = TextEditingController();
  bool _openKeyboard = false;
  final FocusNode _focusNode = FocusNode();
  String currentChatLength = "0/${Utils.chatMaxLength}";

  @override
  void initState() {
    super.initState();
    _minHeight = 0;
    _maxHeight = 250;
    _height = _minHeight;
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentState = context.watch<ChatViewModel>().currentState;
    bool isTypingOrDisable = currentState == ChatState.type || currentState == ChatState.disable;
    bool isTyping = currentState == ChatState.type;
    if (!isTyping) {
      _height = _minHeight;
      _focusNode.unfocus();
      _messageController.clear();
      _openKeyboard = true;
    } else {
      if (_openKeyboard) {
        _openKeyboard = false;
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _focusNode.requestFocus();
          });
        });
      }
    }
    return GestureDetector(
      onTap: (currentState == ChatState.disable) ? widget.clickCallback : null,
      onPanUpdate: (details) => isTyping ? _handlePanUpdate(isEnd: false, dy: details.delta.dy) : null,
      onPanEnd: (details) => isTyping ? _handlePanUpdate(isEnd: true) : null,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: CustomStyle.colorExpandableTextField(context)),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: CustomStyle.colorExpandableTextField(context)
        ),
        child: Stack(
          children: [
            _uiForChatMode(isTypingOrDisable, isTyping),
            Visibility(visible: currentState == ChatState.send, child: _uiForSendingMode()),
            Visibility(visible: currentState == ChatState.nextQuestion, child: _uiForNextQuestionMode())
          ],
        ),
      ),
    );
  }

  Widget _uiForSendingMode() {
    return Positioned.fill(
      child: Center(child: Text(S.current.chat_wait_response, style: CustomStyle.body1B))
    );
  }

  Widget _uiForNextQuestionMode() {
    return Positioned.fill(
      child: Center(
        child: ElevatedButton(onPressed: _newConversation,
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20)),
          child: Text(S.current.chat_next_question, style: CustomStyle.body1B),
        )
      )
    );
  }

  Widget _uiForChatMode(bool isTypingOrDisable, bool isTyping) {
    if (widget.suggestContent != null) {
      _messageController.text = widget.suggestContent!;
      widget.suggestContent = null;
    }
    return Column(
      children: <Widget>[
        Container(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: AnimatedContainer(
            constraints: BoxConstraints(minHeight: _height),
            duration: Duration(milliseconds: _heightAnimDuration),
            child: TextFormField(
              enabled: isTyping,
              focusNode: _focusNode,
              autofocus: isTyping,
              controller: _messageController,
              decoration: InputDecoration(border: InputBorder.none,
                hintStyle: CustomStyle.body2I,
                labelStyle: CustomStyle.body2,
                hintText: isTypingOrDisable ? S.current.chat_send_message_hint : '',
                counter: const Offstage(),
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onChanged: (text) => _onTextChanged(text),
              maxLength: Utils.chatMaxLength,
              minLines: 1,
              maxLines: 10,
            ),
          ),
        ),
        SizedBox(height: 40,
            child: Row(
              children: [
                Container(width: 5),
                Visibility(visible: _messageController.text.isNotEmpty && isTypingOrDisable, child: IconButton(icon: const Icon(Icons.clear), onPressed: _clearMessage)),
                const Spacer(),
                Visibility(visible: isTypingOrDisable, child: Text(currentChatLength, style: CustomStyle.caption)),
                Container(width: 5),
                Visibility(visible: isTypingOrDisable, child: IconButton(onPressed: isTyping ? _sendMessage : null, icon: Icon(Icons.send_rounded, color: CustomStyle.bgColorButton(context)))),
                Container(width: 5)
              ],
            )
        )
      ],
    );
  }

  void _handlePanUpdate({required bool isEnd, double dy = 0}) {
    if (isEnd) {
      setState(() {
        _heightAnimDuration = 200;
        double distance = _maxHeight - _minHeight;
        if (_swipeUp) {
          _height = _height > (_minHeight + 0.3 * distance) ? _maxHeight : _minHeight;
        } else {
          _height = _height < (_maxHeight - 0.3 * distance) ? _minHeight : _maxHeight;
        }
      });
    } else {
      _swipeUp = dy <= 0;
      setState(() {
        _heightAnimDuration = 0;
        _height -= dy;
        if (_height > _maxHeight) {
          _height = _maxHeight;
        } else if (_height < _minHeight) {
          _height = _minHeight;
        }
      });
    }
  }

  void _clearMessage() {
    _messageController.clear();
    setState(() {
      currentChatLength = "0/${Utils.chatMaxLength}";
    });
  }

  void _onTextChanged(String text) {
    setState(() {
      currentChatLength = "${text.length}/${Utils.chatMaxLength}";
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty && widget.sendMessageCallback != null) {
      widget.sendMessageCallback!(_messageController.text);
      _clearMessage();
    }
  }

  void _newConversation() {
    if (widget.newConversationCallback != null) {
      widget.newConversationCallback!();
      _clearMessage();
    }
  }

}