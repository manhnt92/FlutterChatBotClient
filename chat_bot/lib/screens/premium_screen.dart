import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/sub_data.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PremiumScreen extends BaseStatefulWidget {

  const PremiumScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PremiumScreenState();

}

class _PremiumScreenState extends BaseState<PremiumScreen> {

  int _selectedIndex = 1;
  List<SubData> subs = [
    SubData(title: S.current.premium_week, price: S.current.premium_week_price, promotion: S.current.premium_promotion("40")),
    SubData(title: S.current.premium_month, price: S.current.premium_month_price, promotion: S.current.premium_promotion("200"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.premium_title),
        leading: InkWell(
          onTap: () { AppNavigator.goBack(); },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 10),
              Text(S.current.premium_title_hint, textAlign: TextAlign.center, style: CustomStyle.body1B),
              Text(S.current.premium_title_hint_1, textAlign: TextAlign.center, style: CustomStyle.body2),
              Container(height: 10),
              Subscription(onTap: () => onSubscriptionSelected(1),
                  isSelected: _selectedIndex == 1, sub: subs[0]),
              Container(height: 10),
              Subscription(onTap: () => onSubscriptionSelected(2),
                  isSelected: _selectedIndex == 2, sub: subs[1]),
              const SubscriptionFeatures(),
              PlatformElevatedButton(
                onPressed: onSubscription,
                padding: const EdgeInsets.all(10),
                child: Text(S.current.premium_purchase, style: CustomStyle.headline6B),
              ),
              Container(height: 10),
              const SubscriptionTerm()
            ],
          ),
        ),
      ),
    );
  }

  void onSubscription() {

  }

  void onSubscriptionSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}

class Subscription extends BaseStatelessWidget {

  final VoidCallback onTap;
  final bool isSelected;
  final SubData sub;

  const Subscription({Key? key, required this.onTap, required this.isSelected, required this.sub}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onTap: onTap,
      child: Material(
        elevation: 1.0,
        borderOnForeground: true,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, isSelected)),
            color: CustomStyle.colorBgElevatedButton(context, isSelected),
            borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(sub.title, style: CustomStyle.body1B),
                  Text.rich(TextSpan(style: CustomStyle.body2,
                    children: [
                      TextSpan(text: sub.price),
                      const TextSpan(text: ' '),
                      TextSpan(text: sub.promotion, style: CustomStyle.body2B)
                    ]
                  ))
                ]
            ),
          ),
        ),
      ),
    );
  }

}

class SubscriptionFeatures extends BaseStatelessWidget {
  const SubscriptionFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.done),
              Container(width: 10),
              Expanded(child: Text(S.current.premium_feature_1, style: CustomStyle.body2))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.done),
              Container(width: 10),
              Expanded(child: Text(S.current.premium_feature_2, style: CustomStyle.body2))
            ],
          )
        ]
      ),
    );
  }

}

class SubscriptionTerm extends BaseStatelessWidget {

  const SubscriptionTerm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(S.current.premium_purchase_term, style: CustomStyle.body2),
          Container(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () { AppNavigator.goToPrivacy(); },
                  child: Text(S.current.setting_policy, style: CustomStyle.body2.apply(decoration: TextDecoration.underline))),
              Container(width: 15),
              InkWell(
                  onTap: () { AppNavigator.goToTerm(); },
                  child: Text(S.current.setting_term, style: CustomStyle.body2.apply(decoration: TextDecoration.underline)))
            ],
          ),
          Container(height: 10)
        ],
      ),
    );
  }

}