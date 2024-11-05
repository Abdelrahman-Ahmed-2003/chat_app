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
          onTap: (){
            
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30.r,
              child: const Icon(Icons.person,color: Colors.white,),
            ),
            title: Text('User Name',style: TextStyle(fontSize: 18.sp),),
            subtitle: Text(
              'Today 12:00 PM',
              style: TextStyle(color: Colors.blueGrey,fontSize: 14.sp),
            ),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.call)),
          ),
        );
      },
    );
  }
}