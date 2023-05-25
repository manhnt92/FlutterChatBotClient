import 'package:chat_bot/main_view_model.dart';
import 'package:chat_bot/models/aiapp.pb.dart';
import 'package:chat_bot/screens/base.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/utils/app_navigator.dart';
import 'package:chat_bot/utils/app_style.dart';
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
    var viewModel = context.read<MainViewModel>();
    viewModel.getAllConversation();
    _tabSuggestController = TabController(initialIndex: _currentTabIndex, length: context.read<MainViewModel>().suggest.length, vsync: this);
    _tabSuggestController.addListener(() {
      setState(() {
        _currentTabIndex = _tabSuggestController.index;
      });
    });

    if (!viewModel.isPurchased) {
      Future.delayed(const Duration(seconds: 1), () {
        AppNavigator.goToPremiumScreen(false);
      });
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
    var viewModel = context.read<MainViewModel>();
    viewModel.getAllConversation();
  }

  @override
  Widget build(BuildContext context) {
    var chatVm = context.watch<ChatViewModel>();
    var mainVm = context.watch<MainViewModel>();
    String chatTitle;
    if (mainVm.isPurchased) {
      chatTitle = S.current.chat_title;
    } else {
      chatTitle = S.current.free_chat_title(mainVm.freeMessageLeft);
    }
    return WillPopScope(
      onWillPop: () async {
        if (!_isSuggest) {
          updateUI(true);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(_isSuggest ? S.current.home_title : chatTitle),
          leading: _isSuggest ? null : InkWell(
            onTap : () => updateUI(true),
            child: const Icon(Icons.arrow_back),
          ),
          actions: [
            // IconButton(onPressed: () {
            //   AppNavigator.goToPremiumScreen(true);
            // }, icon: Image.asset("assets/images/ic_unlock.png")),
            IconButton(onPressed: () {
              AppNavigator.goToSettingScreen();
            }, icon: const Icon(Icons.settings))
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _isSuggest ? uiForSuggestMode() : Chat(messages: chatVm.messages, currentState: chatVm.currentState),
              ExpandableTextField(clickCallback: _isSuggest ? () => updateUI(!_isSuggest) : null,
                sendMessageCallback: _isSuggest ? null : (text) => sendMessage(text),
                newConversationCallback: () {
                  _currentConversation = null;
                  updateUI(false);
                },
                suggestContent: _currentSuggestItem?.presetContent,
                clearSuggestContentCallback: () {
                  setState(() {
                    _currentSuggestItem = null;
                  });
                },
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
        context.read<MainViewModel>().getAllConversation();
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
    var viewModel = context.watch<MainViewModel>();
    if (context.watch<MainViewModel>().suggest.length != _tabSuggestController.length) {
      _tabSuggestController = TabController(initialIndex: _currentTabIndex, length: context.read<MainViewModel>().suggest.length, vsync: this);
      _tabSuggestController.addListener(() {
        if (_tabSuggestController.indexIsChanging) {
          setState(() {
            _currentTabIndex = _tabSuggestController.index;
          });
        }
      });
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: Row(children: [
              Expanded(child: Text(S.current.home_conversation_history, style: AppStyle.body1B)),
              TextButton(onPressed: () {
                  AppNavigator.goToConversationsScreen()?.then((value) {
                    context.read<MainViewModel>().getAllConversation();
                  });
                },
                child: Text(S.current.home_conversation_view_all, style: AppStyle.body2)
              )
            ]),
          ),
          Visibility(
            visible: viewModel.conversations.isNotEmpty,
            child: SizedBox(
              height: Utils.conversationItemHeight,
              child: ListView.separated(itemCount: viewModel.conversations.length > 5 ? 5 : viewModel.conversations.length, scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctx, int idx) {
                  return _uiForConversationItem(viewModel.conversations[viewModel.conversations.length - 1 - idx]);
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
              child: Center(child: Text(S.current.home_conversation_empty, style: AppStyle.body2)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: Text(S.current.home_suggestion, style: AppStyle.body1B),
          ),
          SizedBox(
            height: 35,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TabBar(
                controller: _tabSuggestController,
                isScrollable: true,
                dividerColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                padding: EdgeInsets.zero,
                // indicator: const BoxDecoration(color: Colors.transparent),
                indicator: BoxDecoration(
                    border: Border.all(color: AppStyle.colorBorder(context, true)),
                    color: AppStyle.colorBgElevatedButton(context, true),
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                indicatorColor: Colors.transparent,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.only(right: 5),
                unselectedLabelStyle: AppStyle.body2,
                labelStyle: AppStyle.body2B,
                tabs: _getTabListWidget(context),
              ),
            ),
          ),
          Container(height: 10),
          Expanded(child: TabBarView(
            controller: _tabSuggestController,
            children: _getTabListContentWidget(),
          ))
        ]
      )
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
        decoration: BoxDecoration(border: Border.all(color: AppStyle.colorBorder(context, false)),
          color: AppStyle.colorBgElevatedButton(context, false),
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
                    Expanded(child: Text(conv.title, style: AppStyle.body2B, maxLines: 2, overflow: TextOverflow.ellipsis)),
                    Text(conv.desc, style: AppStyle.body2, maxLines: 1, overflow: TextOverflow.ellipsis),
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
        context.read<MainViewModel>().updateConversation(conv, newName);
        showToast(context, S.current.toast_rename_conversation_success);
      },
      delete: () {
        context.read<MainViewModel>().deleteConversation(conv);
        showToast(context, S.current.toast_remove_conversation_success);
      }
    );
  }

  List<Tab> _getTabListWidget(BuildContext context) {
    List<Tab> tabs = [];
    var viewModel = context.watch<MainViewModel>();
    for (int i = 0; i < viewModel.suggest.length; i++) {
      // bool isSelectedTab = _currentTabIndex == i;
      var tab = Tab(child:
        Container(
          height: 30,
          /*decoration: BoxDecoration(
            border: Border.all(color: AppStyle.colorBorder(context, isSelectedTab)),
            color: AppStyle.colorBgElevatedButton(context, isSelectedTab),
            borderRadius: const BorderRadius.all(Radius.circular(10))
          ),*/
          child: Row(
            children: [
              Container(width: 15),
              Text(viewModel.suggest[i].title/*, style: isSelectedTab ? AppStyle.body2B : AppStyle.body2*/),
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
    var viewModel = context.watch<MainViewModel>();
    if (viewModel.suggest.isEmpty) {
      return [];
    }
    List<Widget> results = [];
    for (int i = 0; i < viewModel.suggest.length; i++) {
      List<PBSuggestItem> items = viewModel.suggest[i].suggestItem;
      List<Widget> contents = [];
      for (int j = 0; j < items.length; j++) {
        contents.add(Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: InkWell(
            customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onTap: () {
              _currentConversation = null;
              _currentSuggestItem = items[j];
              updateUI(false);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              decoration: BoxDecoration(border: Border.all(color: AppStyle.colorBorder(context, false)),
                  color: AppStyle.colorBgElevatedButton(context, false),
                  borderRadius: const BorderRadius.all(Radius.circular(25))
              ),
              child: Center(child: Text(items[j].title, style: AppStyle.body2, textAlign: TextAlign.center)),
            ),
          ),
        ));
        contents.add(Container(height: 10));
      }
      results.add(Column(children: contents));
    }
    return results;


    /*List<Widget> contents = [];
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
            decoration: BoxDecoration(border: Border.all(color: AppStyle.colorBorder(context, false)),
                color: AppStyle.colorBgElevatedButton(context, false),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            child: Center(child: Text(items[i].title, style: AppStyle.body2, textAlign: TextAlign.center)),
          ),
      )
      );
      contents.add(Container(height: 10));
    }
    return contents;*/
  }

  Future<bool> sendMessage(String text) {
    var future = context.read<ChatViewModel>().sendMessage(text);
    future.then((success) {
      if (!success) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AppNavigator.goToPremiumScreen(true);
        });
      }
    });
    return future;
  }

}