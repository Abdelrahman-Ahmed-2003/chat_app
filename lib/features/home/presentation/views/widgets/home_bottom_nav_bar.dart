import 'package:flutter/material.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Colors.green,
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            color: Colors.green,
          ),
          label: 'Chats',
          tooltip: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.tips_and_updates_rounded,
            color: Colors.green,
          ),
          label: 'Status',
          tooltip: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.call,
            color: Colors.green,
          ),
          label: 'Calls',
          tooltip: 'Calls',
        ),
      ],
    );
  }
}