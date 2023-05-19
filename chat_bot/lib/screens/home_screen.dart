import 'package:chat_bot/main_view_model.dart';
import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/home_vm.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/widgets/chat.dart';
import 'package:chat_bot/screens/chat_vm.dart';
import 'package:chat_bot/widgets/conversation_option_sheet.dart';
import 'package:chat_bot/widgets/expandable_text_field.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends BaseStatefulWidget {

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends BaseState<HomeScreen> with TickerProviderStateMixin {

  bool _isSuggest = true;
  late TabController _tabSuggestController;
  int _currentTabIndex = 0;
  Conversation? _currentConversation;
  PBSuggestItem? _currentSuggestItem;

  @override
  void initState() {
    super.initState();
    var viewModel = context.read<HomeViewModel>();
    viewModel.getAllConversation();
    _tabSuggestController = TabController(initialIndex: _currentTabIndex, length: context.read<MainViewModel>().suggest.length, vsync: this);
    _tabSuggestController.addListener(() {
      if (_tabSuggestController.indexIsChanging) {
        _currentTabIndex = _tabSuggestController.index;
      }
    });
  }

  @override
  void didPopNext() {
    super.didPopNext();
    var viewModel = context.read<HomeViewModel>();
    viewModel.getAllConversation();
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
              AppNavigator.goToSettingScreen();
            }, icon: const Icon(Icons.settings))
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _isSuggest ? uiForSuggestMode() : Chat(messages: context.watch<ChatViewModel>().messages),
              ExpandableTextField(clickCallback: _isSuggest ? () => updateUI(!_isSuggest) : null,
                sendMessageCallback: _isSuggest ? null : (text) => context.read<ChatViewModel>().sendMessage(text),
                newConversationCallback: () {
                  _currentConversation = null;
                  updateUI(false);
                },
                suggestContent: _currentSuggestItem?.presetContent,
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
        context.read<HomeViewModel>().getAllConversation();
        context.read<ChatViewModel>().setCurrentState(ChatState.disable);
        _currentConversation = null;
        _currentSuggestItem = null;
      } else {
        context.read<ChatViewModel>().getAllMessage(_currentConversation);
        context.read<ChatViewModel>().setCurrentState(ChatState.type);
      }
    });
  }

  Widget uiForSuggestMode() {
    return Expanded(child:
      ListView.builder(itemCount: 2, itemBuilder: (BuildContext context, int index) {
        var viewModel = context.watch<HomeViewModel>();
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
                        AppNavigator.goToConversationsScreen()?.then((value) {
                          context.read<HomeViewModel>().getAllConversation();
                        });
                      },
                      child: Text(S.current.home_conversation_view_all, style: CustomStyle.body2)
                    )
                  ],
                ),
                Container(height: 10),
                Visibility(
                  visible: viewModel.conversations.isNotEmpty,
                  child: SizedBox(
                    height: Utils.conversationItemHeight,
                    child: ListView.separated(itemCount: viewModel.conversations.length, scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int idx) {
                        return _uiForConversationItem(viewModel.conversations[idx]);
                      }, separatorBuilder: (BuildContext ctx, int idx) {
                        return Container(width: 10);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: viewModel.conversations.isEmpty,
                  child: SizedBox(
                    height: Utils.conversationItemHeight,
                    child: Center(child: Text(S.current.home_conversation_empty, style: CustomStyle.body2)),
                  ),
                )
              ],
            ),
          );
        } else {
          if (context.watch<MainViewModel>().suggest.length != _tabSuggestController.length) {
            _tabSuggestController = TabController(initialIndex: _currentTabIndex, length: context.read<MainViewModel>().suggest.length, vsync: this);
            _tabSuggestController.addListener(() {
              if (_tabSuggestController.indexIsChanging) {
                _currentTabIndex = _tabSuggestController.index;
              }
            });
          }
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
            tabs: _getTabListWidget(context),
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
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () {
        _currentConversation = conv;
        updateUI(false);
      },
      child: Container(width: Utils.conversationItemWidth,
        decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, false)),
          color: CustomStyle.colorBgElevatedButton(context, false),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => _showConversationOption(conv),
                  customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Icons.more_horiz_outlined),
                  )
                )
              ],
            ),
            Container(height: 5),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: Text(conv.title, style: CustomStyle.body2B, maxLines: 2, overflow: TextOverflow.ellipsis)),
                    Text(conv.desc, style: CustomStyle.body2, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ]
                ),
              ),
            ),

          ],
        )
      ),
    );
  }

  void _showConversationOption(Conversation conv) {
    ConversationOptionSheet.show(context: context, conversation: conv,
      rename: (newName) {
        context.read<HomeViewModel>().updateConversation(conv, newName);
      },
      delete: () {
        context.read<HomeViewModel>().deleteConversation(conv);
      }
    );
  }

  List<Tab> _getTabListWidget(BuildContext context) {
    List<Tab> tabs = [];
    var viewModel = context.watch<MainViewModel>();
    for (int i = 0; i < viewModel.suggest.length; i++) {
      bool isSelectedTab = _currentTabIndex == i;
      var tab = Tab(child:
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: CustomStyle.colorBorder(context, isSelectedTab)),
            color: CustomStyle.colorBgElevatedButton(context, isSelectedTab),
            borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            children: [
              Container(width: 15),
              Text(viewModel.suggest[i].title, style: isSelectedTab ? CustomStyle.body2B : CustomStyle.body2),
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
    var viewModel = context.watch<MainViewModel>();
    if (viewModel.suggest.isEmpty) {
      return contents;
    }
    List<PBSuggestItem> items = viewModel.suggest[_currentTabIndex].suggestItem;
    for (int i = 0 ; i < items.length; i++) {
      contents.add(InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onTap: () {
        _currentConversation = null;
        _currentSuggestItem = items[i];
          updateUI(false);
        },
        child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(border: Border.all(color: CustomStyle.colorBorder(context, false)),
                color: CustomStyle.colorBgElevatedButton(context, false),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            child: Center(child: Text(items[i].title, style: CustomStyle.body2, textAlign: TextAlign.center)),
          ),
      )
      );
      contents.add(Container(height: 10));
    }
    return contents;
  }

}