import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentStatus extends StatelessWidget {
  const RecentStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, itemBuilder: (BuildContext context, int index) { 
        return ListTile(
      leading: CircleAvatar(
        radius: 30.r,
        backgroundImage: const AssetImage('assets/images/logo.png'),
      ),
      title: Text(
        'User name',
        style: Styles.textSytle15,
      ),
      subtitle: Text(
        "Today 12:00 PM",
        style: TextStyle(color: Colors.grey[600],fontSize: 14.sp),
      ),
    );
       },
      
    );
  }
}