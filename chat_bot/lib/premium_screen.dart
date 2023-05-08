import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PremiumScreen extends BaseStatefulScreen {

  const PremiumScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PremiumScreenState();

}

class _PremiumScreenState extends State<PremiumScreen> {

  int _selectedIndex = 0;
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
            ],
          ),
        ),
      ),
    );
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

class Subscription extends StatelessWidget {

  final VoidCallback onTap;
  final bool isSelected;
  final Sub sub;

  const Subscription({Key? key, required this.onTap, required this.isSelected, required this.sub}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: isSelected ? Colors.blue : Colors.black), borderRadius: const BorderRadius.all(Radius.circular(10))),
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
    );
  }

}
