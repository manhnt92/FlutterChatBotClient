
import 'package:chat_bot/utils/app_style.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';

class SimpleListViewItem extends StatelessWidget {

  final VoidCallback onTap;
  Widget? leftWidget;
  Widget? rightWidget;
  String content;

  SimpleListViewItem({super.key, required this.onTap, required this.content, this.leftWidget, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Utils.defaultListViewItemHeight,
      child: InkWell(
        onTap : onTap,
        child: Row(
          children: [
            Visibility(visible: leftWidget != null, child: const SizedBox(width: 15)),
            Visibility(visible: leftWidget != null, child: leftWidget ?? const SizedBox(height: 0)),
            const SizedBox(width: 15),
            Expanded(child: Text(content, style: AppStyle.body2)),
            Visibility(visible: rightWidget != null, child: rightWidget ?? const SizedBox(height: 0)),
            Visibility(visible: rightWidget != null, child: const SizedBox(width: 15))
          ],
        ),
      ),
    );
  }

}