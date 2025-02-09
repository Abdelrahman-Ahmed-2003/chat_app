import 'package:chat_app/features/status/presentation/views/widgets/add_new_status.dart';
import 'package:chat_app/features/status/presentation/views/widgets/delete_status.dart';
import 'package:chat_app/features/status/presentation/views/widgets/head_line.dart';
import 'package:chat_app/features/status/presentation/views/widgets/recent_status.dart';
import 'package:flutter/material.dart';

class StatusBody extends StatefulWidget {
  const StatusBody({super.key});

  @override
  _StatusBodyState createState() => _StatusBodyState();
}

class _StatusBodyState extends State<StatusBody> {
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _checkAndDeleteStatus();
  }

  Future<void> _checkAndDeleteStatus() async {
    try {
      await checkADeleteStatus(); // Call your existing function to delete expired statuses
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text('Errorrrrrrr: $errorMessage'));
    }

    return ListView(
      children: const [
        AddNewStatus(),
        HeadLine(title: 'Recent updates'),
        RecentStatus(), // Pass the statuses to RecentStatus
        // const HeadLine(title: "Viewed updates"),
        // ViewedStatus(),
        // MutedBody()
      ],
    );
  }
}