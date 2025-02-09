import 'package:chat_app/core/state_managment/contacts_provider.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/new_group.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/search.dart';
import 'package:chat_app/features/profile/presentation/views/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
       toolbarHeight: 80.h,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
          width: 0.5.w,
        ),
      ),
      backgroundColor: Colors.grey.withOpacity(.05),
      title: Text(
        'WhatsUp',
        style: TextStyle(
          fontSize: 23.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Search()),
            );
          },
        ),PopupMenuButton<String>(
          elevation: 0,
          position: PopupMenuPosition.under,

          constraints: const BoxConstraints(
            minWidth: 200,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'New Group',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NewGroup(),
                  ));
                },
                child: Text('New Group',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
              ),
              PopupMenuItem<String>(
                value: 'Profile',
                child: Text('Profile',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileView(),
                  ));
                },
              ),
              PopupMenuItem<String>(
                value: 'Log out',
                child: Text('Log out',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp)),
                onTap: () async{
                  var provider = context.read<ConversationProvider>();
                  var contactProvider = context.read<ContactsProvider>();
                  provider.clear();
                  contactProvider.clear();
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginView()));
                },
              ),
            ];
          },
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  @override
   Size get preferredSize => Size.fromHeight(80.h); 
}