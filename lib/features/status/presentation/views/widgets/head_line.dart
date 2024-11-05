import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadLine extends StatelessWidget {
  final String title;
  const HeadLine({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding:const EdgeInsets.all(20),
      child: Text(title,style: TextStyle(color: Colors.grey,fontSize: 14.sp),),
    );
  }
}
