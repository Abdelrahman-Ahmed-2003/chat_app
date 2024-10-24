import 'package:chat_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';

class ChatViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      backgroundColor: Colors.grey.withOpacity(.05),
      title: const Text(
        'WhatsUp',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          elevation: 0,
          position: PopupMenuPosition.under,

          constraints: const BoxConstraints(
            minWidth: 200,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const NewGroupView(),
                  // ));
                },
                child: const Text('New Group',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              PopupMenuItem<String>(
                value: 'Profile',
                child: const Text('Profile',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileView(),
                  ));
                },
              ),
              PopupMenuItem<String>(
                value: 'Log out',
                child: const Text('Log out',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  //log out
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}