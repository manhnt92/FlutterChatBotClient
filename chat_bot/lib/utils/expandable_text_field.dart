import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';

class ExpandableTextField extends StatefulWidget {

  final VoidCallback? clickCallback;
  final bool Function(String)? sendMessageCallback;
  final bool enable;

  const ExpandableTextField({Key? key, this.sendMessageCallback, this.clickCallback, required this.enable}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField>  {

  late double _height, _minHeight, _maxHeight;
  bool _swipeUp = true;
  int _heightAnimDuration = 0;
  final TextEditingController _messageController = TextEditingController();
  bool canFocus = false;
  final FocusNode focusNode = FocusNode();
  String currentChatLength = "0/${Utils.chatMaxLength}";

  @override
  void initState() {
    super.initState();
    _minHeight = 50;
    _maxHeight = 270;
    _height = _minHeight;
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (!widget.enable) {
        _height = _minHeight;
        _messageController.clear();
        canFocus = true;
      } else {
        if (canFocus) {
          canFocus = false;
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              debugPrint("request focus");
              focusNode.requestFocus();
            });
          });
        }
      }
    });
    return GestureDetector(
      onTap: widget.enable ? null : widget.clickCallback,
      onPanUpdate: (details) => widget.enable ? handlePanUpdate(isEnd: false, dy: details.delta.dy) : null,
      onPanEnd: (details) => widget.enable ? handlePanUpdate(isEnd: true) : null,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: CustomStyle.colorExpandableTextField(context)),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: CustomStyle.colorExpandableTextField(context)
        ),
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AnimatedContainer(
                constraints: BoxConstraints(minHeight: _height),
                duration: Duration(milliseconds: _heightAnimDuration),
                child: TextFormField(
                    enabled: widget.enable,
                    focusNode: focusNode,
                    autofocus: widget.enable,
                    controller: _messageController,
                    decoration: InputDecoration(border: InputBorder.none,
                      hintStyle: CustomStyle.body2I,
                      labelStyle: CustomStyle.body2,
                      hintText: S.current.chat_send_message_hint,
                      counter: const Offstage(),
                      // constraints: /*_swipeUp ?*/ BoxConstraints(minHeight: _height) /*: BoxConstraints(minHeight: _height, maxHeight: _height)*/,
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    onChanged: (text) => onMessageChanged(text),
                    maxLength: Utils.chatMaxLength,
                    minLines: 1,
                    maxLines: 10,
                ),
              ),
            ),
            const Divider(height: 1),
            SizedBox(height: 45,
                child: Row(
                  children: [
                    Container(width: 5),
                    Visibility(visible: _messageController.text.isNotEmpty, child: IconButton(icon: const Icon(Icons.clear), onPressed: clearMessage)),
                    const Spacer(),
                    Visibility(visible: widget.enable, child: Text(currentChatLength, style: CustomStyle.caption)),
                    Container(width: 5),
                    IconButton(onPressed: widget.enable ? sendMessage : null, icon: Icon(Icons.send_rounded, color: CustomStyle.bgColorButton(context))),
                    Container(width: 5)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  void handlePanUpdate({required bool isEnd, double dy = 0}) {
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

  void clearMessage() {
    _messageController.clear();
    setState(() {
      currentChatLength = "0/${Utils.chatMaxLength}";
    });
  }

  void onMessageChanged(String text) {
    setState(() {
      currentChatLength = "${text.length}/${Utils.chatMaxLength}";
    });
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty && widget.sendMessageCallback != null) {
      bool success = widget.sendMessageCallback!(_messageController.text);
      if (success) {
        clearMessage();
      }
    }
  }

}