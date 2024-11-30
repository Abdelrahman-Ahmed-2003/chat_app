import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallBody extends StatelessWidget {
  const CallBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {},
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20.sp,
                      child: Icon(
                        Icons.person,
                        size: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                        width: 16.0), // Add spacing between avatar and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User Name', style: TextStyle(fontSize: 18.sp)),
                          Text(
                            'Today 12:00 PM',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call, size: 20.sp),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
