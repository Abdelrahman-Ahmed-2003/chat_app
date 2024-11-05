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
          onTap: () {
            
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30.r,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text('User Name',style: TextStyle(fontSize: 20.sp),),
            subtitle: Row(
              children: [
                Icon(Icons.done_all, color: Colors.blueGrey, size: MediaQuery.of(context).size.height * 0.02),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  'This is the last message',
                  style: TextStyle(color: Colors.blueGrey,fontSize: 14.sp),
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('10:00',style: TextStyle(fontSize: 14.sp),),
                Flexible(
                    child: CircleAvatar(
                  radius: 13.0.r,
                  child: Text('2',style: TextStyle(fontSize: 14.sp),),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
