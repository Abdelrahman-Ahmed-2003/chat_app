import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Photo extends StatelessWidget {
  const Photo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.r,
            backgroundImage: const AssetImage('assets/images/logo.png'),
          ),
          Positioned(
            bottom: 0,
            right: 1,
            child: Container(
              height: 20.h,
              width: 20.w,
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
                    Icons.camera_alt,
                    color: Colors.green,
                    size: MediaQuery.of(context).size.height * 0.018,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
