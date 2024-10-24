import 'package:flutter/material.dart';

class HeadLine extends StatelessWidget {
  final String title;
  const HeadLine({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding:const EdgeInsets.all(20),
      child: Text(title,style: const TextStyle(color: Colors.grey),),
    );
  }
}
