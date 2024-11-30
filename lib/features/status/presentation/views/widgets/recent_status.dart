import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentStatus extends StatelessWidget {
  const RecentStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 42.w, // Adjust the width as needed
                    height: 42.w, // Maintain aspect ratio for a circle
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                      width: 16.0), // Add spacing between avatar and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User name',
                          style: Styles.textSytle15.copyWith(fontSize: 15.sp),
                        ),
                        Text(
                          "Today 12:00 PM",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
