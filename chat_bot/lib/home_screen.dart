import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/utils/expandable_text_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseStatefulWidget {

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  bool _isSuggest = true;
  bool _canSendMessage = true;
  late TabController _tabSuggestController;
  int _currentTabIndex = 0;
  List<String> tabsTitle = [
    'Education', 'Fun', 'Daily Lifestyle', 'Health & Nutrition', 'Astrology',
    'Art', 'Travel', 'Business & Marketing', 'Social', 'Career', 'E-mail'
  ];
  List<Map<String, String>> tabsContent = [
    {
      'Science Chat' : '',
      'English Teacher' : '',
      'Translator' : '',
      'Math Teacher' : '',
      'Create a Short Essay on any Topic' : '',
      'Citation Generator for any style' : '',
      'Course Generator on any Topic' : '',
    },
    {
      'Talk to Neo in the Matrix': '',
      'Dream Interpreter': '',
      'Turn any text into emoji': '',
      'Cat-Friend': '',
      'Tell me a joke': '',
      'Give advice like Elon Musk about Car': '',
      'Kyle in South Park': '',
      'Play Chess': '',
      'Play Trivia Quest': '',
      'Minecraft Steve': '',
      'Eminem-style Jokes about Max Payne': '',
      'Son Goku in Dragon Ball': '',
    },
    {
      'Daily Horoscope/Love, Money, Mood, Health': '',
      'Outfit Idea (Harmonious with Event Concept)': '',
      'How many liters of water should I drink in a day?': '',
      'Make-Up Idea compatible with Concept and Outfit': '',
      'Meal Order Idea for Breakfast, Lunch, Dinner, and Night Snacks': '',
      'Jovial Mentor Wisdom for Lifes Queries': ''
    },
    {
      'Life Coach': '',
      'Dietitian': '',
      '6 yoga Poses': '',
      '3 Tips to Get Sleep More Efficient': '',
      'Recipe for My Ingredients, Meal and Diet type': '',
      'How many calories should I eat in a day?': '',
      'Youtube Channels about Health, Nutrition and Sports': '',
      'Training Plan Generator': ''
    },
    {
      'Daily Horoscope/Love, Money, Mood, Health': '',
      'What are 10 characteristic features of my zodiac sign?': '',
      'Interpretation your Horoscope Map': '',
      'Tarot Analysis': '',
      'Weekly Horoscope': '',
      'Music & Movies match with your Zodiac Sign': '',
      'Is an Aries Woman and Gemini Man a Good Match?': ''
    },
    {
      'Write J.K.Rowling-style Short Story': '',
      'Write Travis Scott-style Song Lyrics': '',
      'Create a Playlist Similar to your Favourite Song': '',
      'Storyteller': '',
      'Book Recommendations': '',
      'Poem Generator': '',
      'Movie and Series Critic': '',
      'Song Recommendation match for your Mood and Genre': '',
      'Write a South Park Episode': ''
    },
    {
      'Vacation Planner': '',
      'Local Foods': '',
      'Best time to Visit': '',
      'Activities': '',
      'Budgeting Tips': '',
      'Prepare Itinerary': '',
      'Cultural Legal Advisor For Safe Travels': '',
      'Time-Travel Machine': ''
    },
    {
      'Sell me this pen!': '',
      'Social Media Manager': '',
      'Business Idea': '',
      'Digital Marketing Strategy': '',
      'SEO Generator': '',
      'Slide Presentation': '',
      'Prepare a Professional Business Plan': '',
      'All-in-one Marketing': '',
      'Social Media Caption Generator': ''
    },
    {
      'Gift Ideas': '',
      'Suggest 3 Event Ideas': '',
      "Win someone's heart on a dating app": '',
      'Ice Breaker Game without any materials': '',
      'Outfit Idea (Harmonious with Event Concept)': '',
      'New Topic to Open a Conversation': '',
      'Birthday Message': ''
    },
    {
      'Generate Secure Passwords': '',
      'Interview Question': '',
      'Career Counselor': '',
      'Self-Help Book': '',
      'Statistician': '',
      'Financial Planning': '',
      'To-Do List Creator for Specific Task': ''
    },
    {
      'Write Am Email To Promote The Sale': '',
      'Newsletter Template': '',
      'Mail Response For Angry Client': '',
      'Email Subject Lines For High Open Rates': '',
      'Mass Marketing Email': '',
      'Text Formalizer Prettifier And Fixer' : '',
      'Email Responder (Friendly/Professional)': ''
    }
  ];

  List<QAMessage> messages = [
    QAMessage.createQAMsgTest(question: 'hello', canPlayAnswerAnim: false)
  ];

  @override
  void initState() {
    super.initState();
    _tabSuggestController = TabController(initialIndex: _currentTabIndex, length: tabsTitle.length, vsync: this);
    _tabSuggestController.addListener(() {
      setState(() {
        if (_tabSuggestController.indexIsChanging) {
          _currentTabIndex = _tabSuggestController.index;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_isSuggest) {
          updateUI(true);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(_isSuggest ? S.current.home_title : S.current.chat_title),
          leading: _isSuggest ? null : InkWell(
            onTap : () => updateUI(true),
            child: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(onPressed: () {
              CustomNavigator.goToSettingScreen();
            }, icon: const Icon(Icons.settings))
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _isSuggest ? uiForSuggestMode() : uiForChatMode(),
              ExpandableTextField(clickCallback: _isSuggest ? () => updateUI(!_isSuggest) : null,
                  sendMessageCallback: _isSuggest ? null : (text) => sendMessage(text),
                  enable: !_isSuggest
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateUI(bool isSuggest) {
    setState(() {
      _isSuggest = isSuggest;
    });
  }

  Widget uiForSuggestMode() {
    return Expanded(child:
      ListView.builder(itemCount: 2, itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(S.current.home_chat_history, style: CustomStyle.body1B),
                Container(height: 10)
              ],
            ),
          );
        } else /*if (index == 1)*/ {
          List<Widget> children = [];
          children.add(Text(S.current.home_suggestion, style: CustomStyle.body1B));
          children.add(Container(height: 10));
          children.add(TabBar(
            controller: _tabSuggestController,
            isScrollable: true,
            dividerColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            padding: EdgeInsets.zero,
            indicator: const BoxDecoration(color: Colors.transparent),
            indicatorColor: Colors.transparent,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.only(right: 5),
            tabs: getTabListWidget(),
          ));
          children.addAll(getTabListContentWidget());
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: children
            ),
          );
        }
      })
    );
  }

  List<Tab> getTabListWidget() {
    List<Tab> tabs = [];
    for (int i = 0; i < tabsTitle.length; i++) {
      bool isSelectedTab = _currentTabIndex == i;
      var tab = Tab(child:
      Container(
        height: 30,
        decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, isSelectedTab)),
            color: CustomStyle.colorBgElevatedButton(context, isSelectedTab),
            borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: Row(
          children: [
            Container(width: 15),
            Text(tabsTitle[i], style: isSelectedTab ? CustomStyle.body2B : CustomStyle.body2),
            Container(width: 15)
          ],
        ),
      )
      );
      tabs.add(tab);
    }
    return tabs;
  }

  List<Widget> getTabListContentWidget() {
    List<Widget> contents = [];
    Map<String, String> map = tabsContent[_currentTabIndex];
    List<String> keys = map.entries.map((e) => e.key).toList();
    for (int i = 0 ; i < keys.length; i++) {
      contents.add(InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onTap: () => {},
        child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, false)),
                color: CustomStyle.colorBgElevatedButton(context, false),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            child: Center(child: Text(keys[i], style: CustomStyle.body2, textAlign: TextAlign.center)),
          ),
      )
      );
      contents.add(Container(height: 10));
    }
    return contents;
  }

  Widget uiForChatMode() {
    return Expanded(
      child: ListView.separated (itemCount: messages.length,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, i) {
          var msg = messages[messages.length - 1 - i];
          return uiForQAMessage(context, msg);
        }, separatorBuilder: (_, i) => Container(height: 0),
      ),
    );
  }

  Widget uiForQAMessage(BuildContext context, QAMessage message) {
    return Column(
      children: [
        Container(
          color: CustomStyle.colorBgElevatedButton(context, false),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 15),
                  const Icon(Icons.person),
                  const SizedBox(width: 5),
                  Text('Me', style: CustomStyle.body2B, softWrap: true)
                ]
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Flexible(child: Text(message.question, style: CustomStyle.body2, softWrap: true)),
                  const SizedBox(width: 15)
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
        Visibility(
          visible: message.answer.isNotEmpty,
          child: Container(
              color: CustomStyle.colorBgElevatedButton(context, true),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(Icons.computer),
                        const SizedBox(width: 5),
                        Text('Bot', style: CustomStyle.body2B, softWrap: true)
                      ]
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Expanded(child: message.canPlayAnswerAnim ? AnimatedTextKit(
                        repeatForever: false,
                        isRepeatingAnimation:false,
                        totalRepeatCount: 0,
                        pause: const Duration(milliseconds: 200),
                        animatedTexts: [
                          TyperAnimatedText('', textStyle: CustomStyle.body2),
                          TyperAnimatedText(message.answer, textStyle: CustomStyle.body2)
                        ],
                        onNext: (index, isLast) {
                          debugPrint('onNext : $index, $isLast');
                          _canSendMessage = false;
                          message.canPlayAnswerAnim = false;
                        },
                        onFinished: () {
                          debugPrint('onFinish');
                          _canSendMessage = true;
                        },
                      ) : Text(message.answer, style: CustomStyle.body2, softWrap: true)
                      ),
                      const SizedBox(width: 15)
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              )
          ),
        )
      ],
    );
  }

  bool sendMessage(String text) {
    if (text.isNotEmpty && _canSendMessage) {
      QAMessage message = QAMessage.createQAMsgTest(question: text, answer : "", canPlayAnswerAnim: true);
      setState(() {
        messages.add(message);
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          message.setAnswerTest();
        });
      });
      return true;
    }
    return false;
  }

}