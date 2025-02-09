import 'package:chat_app/features/chat/presentation/views/widgets/name_and_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


FloatingActionButton createNewGroupFloatingActionButton(
    BuildContext context, Set<Map<String, dynamic>> members) {
  return FloatingActionButton(
    onPressed: () async {
      if (members.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please select members of group',
            style: TextStyle(fontSize: 20.sp),
          ),
        ));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NameAndPhoto(members: members)));
        print('data selectedddddddddddddddddddddddddddddddddddddddddddddddddddddd');
        print(members);
        
      }
    },
    child: const Icon(Icons.group_add),
  );
}
