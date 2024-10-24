import 'package:chat_app/features/status/presentation/views/widgets/add_new_status.dart';
import 'package:chat_app/features/status/presentation/views/widgets/head_line.dart';
import 'package:chat_app/features/status/presentation/views/widgets/muted_body.dart';
import 'package:chat_app/features/status/presentation/views/widgets/recent_status.dart';
import 'package:chat_app/features/status/presentation/views/widgets/viewed_status.dart';
import 'package:flutter/material.dart';

class StatusBody extends StatelessWidget {
  const StatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: const[
          AddNewStatus(),
          HeadLine(title: 'Recent updates'),
          RecentStatus(),
          HeadLine(title: "Viewed updates"),
          ViewedStatus(),
          MutedBody()
        ],
      );
  }
}
