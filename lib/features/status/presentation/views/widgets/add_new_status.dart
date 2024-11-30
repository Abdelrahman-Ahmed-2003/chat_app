import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewStatus extends StatelessWidget {
  const AddNewStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding:const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            // First Row for Stack and Title/Subtitle
            children: [
              Stack(
                // Leading Stack
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30.sp,
                    child: Icon(
                      Icons.person,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 1,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Colors.green,
                            size: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16.0), // Spacing between Stack and Text
              Expanded(
                // Title and Subtitle column
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Abdo Ahmed',
                      style: Styles.textSytle15.copyWith(fontSize: 15.sp),
                    ),
                    const SizedBox(width: 8.0), // Spacing between Title and Subtitle
                    Text(
                      "Tap to add new status",
                      style:
                          TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}