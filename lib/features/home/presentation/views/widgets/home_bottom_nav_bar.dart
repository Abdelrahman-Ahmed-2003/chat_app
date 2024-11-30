import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.sp
      ),
      unselectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 17.sp),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Colors.green,
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            size: 20.sp,
            color: Colors.green,
          ),
          label: 'Chats',
          tooltip: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            size: 20.sp,
            Icons.tips_and_updates_rounded,
            color: Colors.green,
          ),
          label: 'Status',
          tooltip: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            size: 20.sp,
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