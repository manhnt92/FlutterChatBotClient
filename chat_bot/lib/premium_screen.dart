import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:flutter/material.dart';

class PremiumScreen extends BaseStatelessScreen {

  PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.premium_title),
        leading: InkWell(
          onTap: goBack,
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }

}