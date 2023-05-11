import 'package:chat_bot/base/base_screen.dart';
import 'package:chat_bot/generated/l10n.dart';
import 'package:chat_bot/models/qa_message.dart';
import 'package:chat_bot/screens/home_vm.dart';
import 'package:chat_bot/utils/custom_navigator.dart';
import 'package:chat_bot/utils/custom_style.dart';
import 'package:chat_bot/widgets/chat.dart';
import 'package:chat_bot/widgets/chat_vm.dart';
import 'package:chat_bot/widgets/expandable_text_field.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:chat_bot/widgets/list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends BaseStatefulWidget {

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  bool _isSuggest = true;
  late TabController _tabSuggestController;
  int _currentTabIndex = 0;
  Conversation? _currentConversation;

  @override
  void initState() {
    super.initState();
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.getAllConversation();
    _tabSuggestController = TabController(initialIndex: _currentTabIndex, length: viewModel.tabsTitle.length, vsync: this);
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
              _isSuggest ? uiForSuggestMode() : Chat(conversation: _currentConversation),
              ExpandableTextField(clickCallback: _isSuggest ? () => updateUI(!_isSuggest) : null,
                  sendMessageCallback: _isSuggest ? null : (text) => context.read<ChatViewModel>().sendMessage(text),
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
        context.read<HomeViewModel>().getAllConversation();
        _currentConversation = null;
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
                        CustomNavigator.goToConversationHistory();
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
      ),
    );
  }

  void _showConversationOptionSheet(BuildContext context, Conversation conv) {
    TextEditingController renameController = TextEditingController();
    FocusNode focusNode = FocusNode();
    showModalBottomSheet<void>(context: context, builder: (BuildContext ctx) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 30),
              TextFormField(
                focusNode: focusNode,
                controller: renameController,
                decoration: InputDecoration(border: InputBorder.none,
                  hintStyle: CustomStyle.body2I,
                  labelStyle: CustomStyle.body2,
                  hintText: conv.title,
                  counter: const Offstage(),
                  contentPadding: const EdgeInsets.only(left: 15, right: 15)
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLength: Utils.chatMaxLength,
                maxLines: 1,
              ),
              SimpleListViewItem(
                onTap: () {
                  if (renameController.text.isNotEmpty) {
                    context.read<HomeViewModel>().updateConversation(conv, renameController.text);
                    Navigator.pop(ctx);
                  } else {
                    focusNode.requestFocus();
                  }
                },
                content: S.current.home_conversation_rename,
                leftWidget: const Icon(Icons.edit),
              ),
              const Divider(height: 1),
              SimpleListViewItem(
                onTap: () {
                  context.read<HomeViewModel>().deleteConversation(conv);
                  renameController.dispose();
                  Navigator.pop(ctx);
                },
                content: S.current.home_conversation_delete,
                leftWidget: const Icon(Icons.delete),
              ),
              Container(height: 30)
            ],
          ),
        );
      },
    );
  }

  List<Tab> _getTabListWidget(BuildContext context) {
    List<Tab> tabs = [];
    var viewModel = context.watch<HomeViewModel>();
    for (int i = 0; i < viewModel.tabsTitle.length; i++) {
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
              Text(viewModel.tabsTitle[i], style: isSelectedTab ? CustomStyle.body2B : CustomStyle.body2),
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
    var viewModel = context.watch<HomeViewModel>();
    Map<String, String> map = viewModel.tabsContent[_currentTabIndex];
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

}