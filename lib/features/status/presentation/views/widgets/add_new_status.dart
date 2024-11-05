import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewStatus extends StatelessWidget {
  const AddNewStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: const AssetImage('assets/images/logo.png'),
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
                border: Border.all(
                  color: Colors.green,
                  width: 2.w,
                ),
              ),
              child: Center(
                child: IconButton(
                  padding: EdgeInsets.zero, // Remove default padding
                  constraints:
                      const BoxConstraints(), // Remove default constraints
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Colors.green,
                    size: MediaQuery.of(context).size.height * 0.015,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        'Abdo Ahmed',
        style: Styles.textSytle15,
      ),
      subtitle: Text(
        "Tap to add new status",
        style: TextStyle(color: Colors.grey[600],fontSize: 14.sp),
      ),
    );
  }
}
