import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/utils/expandable_text_field.dart';
import 'package:chat_bot/utils/sqlite.dart';
import 'package:chat_bot/utils/utils.dart';
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
  final List<Conversation> _conversations = [
    Conversation(id: 1, title: "Hello world c++ Hello world c++ Hello world c++", desc: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", type: 0),
    Conversation(id: 1, title: "Hello world c++", desc: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", type: 0)
  ];
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
    _getAllConversations();
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
              _isSuggest ? uiForSuggestMode() : _uiForChatMode(),
              ExpandableTextField(clickCallback: _isSuggest ? () => updateUI(!_isSuggest) : null,
                  sendMessageCallback: _isSuggest ? null : (text) => _sendMessage(text),
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
      if (_isSuggest) {
        _getAllConversations();
      }
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
                Row(
                  children: [
                    Expanded(child: Text(S.current.home_conversation_history, style: CustomStyle.body1B)),
                    TextButton(onPressed: () {
                        CustomNavigator.goToConversationHistory();
                      },
                      child: Text(S.current.home_conversation_view_all, style: CustomStyle.body2)
                    )
                  ],
                ),
                Container(height: 10),
                Visibility(
                  visible: _conversations.isNotEmpty,
                  child: SizedBox(
                    height: Utils.conversationItemHeight,
                    child: ListView.separated(itemCount: _conversations.length, scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return _uiForConversationItem(_conversations[idx]);
                      }, separatorBuilder: (BuildContext ctx, int idx) {
                        return Container(width: 10);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: _conversations.isEmpty,
                  child: SizedBox(
                    height: Utils.conversationItemHeight,
                    child: Center(child: Text(S.current.home_conversation_empty, style: CustomStyle.body2)),
                  ),
                )
              ],
            ),
          );
        } else {
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
            tabs: _getTabListWidget(),
          ));
          children.addAll(_getTabListContentWidget());
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

  Widget _uiForConversationItem(Conversation conv) {
    return Container(width: Utils.conversationItemWidth,
      decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, false)),
        color: CustomStyle.colorBgElevatedButton(context, false),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Text(conv.title, style: CustomStyle.body2B, maxLines: 2, overflow: TextOverflow.ellipsis)),
                  Text(conv.desc, style: CustomStyle.body2, maxLines: 1, overflow: TextOverflow.ellipsis),
                ]
              ),
            ),
          ),
          Container(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => _showConversationOptionSheet(context, conv),
                customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(Icons.more_horiz_outlined),
                )
              )
            ],
          )
        ],
      )
    );
  }

  void _showConversationOptionSheet(BuildContext context, Conversation conv) {
    showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Modal BottomSheet'),
              ElevatedButton(
                child: const Text(S.current.home_conversation_delete),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Tab> _getTabListWidget() {
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

  List<Widget> _getTabListContentWidget() {
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

  Widget _uiForChatMode() {
    return Expanded(
      child: ListView.separated (itemCount: messages.length,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, i) {
          var msg = messages[messages.length - 1 - i];
          return _uiForQAMessage(context, msg);
        }, separatorBuilder: (_, i) => Container(height: 0),
      ),
    );
  }

  Widget _uiForQAMessage(BuildContext context, QAMessage message) {
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

  bool _sendMessage(String text) {
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

  void _getAllConversations() {
    SQLite.instance.getAllConversation().then((value) {
      setState(() {
        _conversations.addAll(value);
      });
    });
  }

}