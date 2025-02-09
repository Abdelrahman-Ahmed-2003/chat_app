import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/call/presentation/views/call_view.dart';
import 'package:chat_app/features/chat/presentation/views/chat_view.dart';
import 'package:chat_app/features/home/presentation/views/widgets/home_bottom_nav_bar.dart';
import 'package:chat_app/features/status/presentation/views/status_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> pages = [
    const ChatView(),
    const StatusView(),
    const CallView(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  Future<void> callFetchSender() async {
    var provider = Provider.of<ConversationProvider>(context, listen: false);
    await provider.fetchSender();
    print(
        'number of senderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    print(provider.sender!['phone_num']);
  }

  @override
  void initState() {
    super.initState();
    callFetchSender();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: pages,
      ),
    );
  }
}
