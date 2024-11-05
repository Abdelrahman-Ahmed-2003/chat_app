import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget{
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Profile',style: TextStyle(fontSize: 25.sp),),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}