import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PremiumScreen extends BaseStatefulWidget {

  const PremiumScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PremiumScreenState();

}

class _PremiumScreenState extends State<PremiumScreen> {

  int _selectedIndex = 1;
  List<Sub> subs = [
    Sub(title: S.current.premium_week, price: S.current.premium_week_price, promotion: S.current.premium_promotion("40")),
    Sub(title: S.current.premium_month, price: S.current.premium_month_price, promotion: S.current.premium_promotion("200"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.premium_title),
        leading: InkWell(
          onTap: widget.goBack,
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
              Container(height: 20),
              Text(S.current.premium_title_hint, textAlign: TextAlign.center, style: CustomStyle.headline6B),
              Text(S.current.premium_title_hint_1, textAlign: TextAlign.center, style: CustomStyle.body1),
              Container(height: 20),
              Subscription(onTap: () => onSubscriptionSelected(1),
                  isSelected: _selectedIndex == 1, sub: subs[0]),
              Container(height: 20),
              Subscription(onTap: () => onSubscriptionSelected(2),
                  isSelected: _selectedIndex == 2, sub: subs[1]),
              Container(height: 20),
              const SubscriptionFeatures(),
              PlatformElevatedButton(
                onPressed: onSubscription,
                padding: const EdgeInsets.all(20),
                child: Text(S.current.premium_purchase, style: CustomStyle.headline5B),
              ),
              Container(height: 20),
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

class Sub {
  String title;
  String price;
  String promotion;

  Sub({required this.title, required this.price, required this.promotion});
}

class Subscription extends BaseStatelessWidget {

  final VoidCallback onTap;
  final bool isSelected;
  final Sub sub;

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
          decoration: BoxDecoration(border: Border.all(color: getHighlightColor(context, isSelected)),
            color: CustomStyle.colorLikeButtonBg(context, isSelected),
            borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(sub.title, style: CustomStyle.headline6B),
                  Container(height: 5),
                  Text.rich(TextSpan(style: CustomStyle.body1,
                    children: [
                      TextSpan(text: sub.price),
                      const TextSpan(text: ' '),
                      TextSpan(text: sub.promotion, style: CustomStyle.body1B)
                    ]
                  ))
                ]
            ),
          ),
        ),
      ),
    );
  }

  Color getHighlightColor(BuildContext context, bool isSelected) {
    if (isInDarkMode(context)) {
      return isSelected ? CustomStyle.colorSchemeDark.surfaceTint.withAlpha(122) : Colors.transparent;
    }
    return isSelected ? CustomStyle.colorScheme.surfaceTint.withAlpha(122) : Colors.transparent;
  }

}

class SubscriptionFeatures extends BaseStatelessWidget {
  const SubscriptionFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.done),
              Expanded(child: Text(S.current.premium_feature_1, style: CustomStyle.body1))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.done),
              Expanded(child: Text(S.current.premium_feature_2, style: CustomStyle.body1))
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
          Text(S.current.premium_purchase_term, style: CustomStyle.subtitle2),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: goToPrivacy,
                  child: Text(S.current.setting_policy, style: CustomStyle.subtitle2.apply(decoration: TextDecoration.underline))),
              Container(width: 20),
              InkWell(
                  onTap: goToTerm,
                  child: Text(S.current.setting_term, style: CustomStyle.subtitle2.apply(decoration: TextDecoration.underline)))
            ],
          ),
          Container(height: 20)
        ],
      ),
    );
  }

  void goToPrivacy() {
    Utils.instance.goToPrivacy();
  }

  void goToTerm() {
    Utils.instance.goToTerm();
  }
  
}