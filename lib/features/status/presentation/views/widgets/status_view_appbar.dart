import 'package:chat_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  const StatusViewAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
          width: 0.5.w,
        ),
      ),
      backgroundColor: Colors.grey.withOpacity(.05),
      title: Text(
        'Status',
        style: TextStyle(
          fontSize: 23.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(
              color: Colors.grey,
              width: 0.5.w,
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
                child: Text('New Group',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp)),
              ),
              PopupMenuItem<String>(
                value: 'Profile',
                child: Text('Profile',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileView(),
                  ));
                },
              ),
              PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp)),
                onTap: () {},
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