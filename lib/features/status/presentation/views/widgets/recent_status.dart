import 'package:chat_app/core/state_managment/contacts_provider.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/presentation/views/widgets/fetch_media.dart';
import 'package:chat_app/features/status/presentation/views/widgets/view_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RecentStatus extends StatelessWidget {
  const RecentStatus({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ContactsProvider>();
    return FutureBuilder(
        future: fetchStatusUpdates(provider.contacts),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final status = snapshot.data;
          print('all statusssssssssssssssssssssssssssssssssssssssssss');
          print(status.toString());
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: status!.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print(
                            'status before navigateeeeeeeeeeeeeeeeeeeeeeeeeee');
                        print(status[index].statusDetails.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewStatus(
                                      status: status[index],
                                    )));
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 42.w, // Adjust the width as needed
                            height: 42.w, // Maintain aspect ratio for a circle
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/logo.png'),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  16.0), // Add spacing between avatar and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  status[index].name,
                                  style: Styles.textSytle15
                                      .copyWith(fontSize: 15.sp),
                                ),
                                // Text(
                                //   "Today 12:00 PM",
                                //   style: TextStyle(
                                //       color: Colors.grey[600], fontSize: 14.sp),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          );
        });
  }
}
