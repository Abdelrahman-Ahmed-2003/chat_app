import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: Row(
            children: [
              // Leading Avatar
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20.sp,
                child: Icon(
                  Icons.person,
                  size: 18.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w), // Space between avatar and text section

              // Title and Subtitle Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(height: 4.h), // Space between title and subtitle
                    Row(
                      children: [
                        Icon(Icons.done_all,
                            color: Colors.blueGrey, size: 17.sp),
                        SizedBox(width: 5.w), // Space between icon and text
                        Text(
                          'This is the last message',
                          style: TextStyle(
                              color: Colors.blueGrey, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Trailing Time and Notification Section
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '10:00',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(
                      height: 8.h), // Space between time and notification icon
                  CircleAvatar(
                    radius: 10.0.sp,
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
