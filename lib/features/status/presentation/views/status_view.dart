import 'package:chat_app/features/status/presentation/views/widgets/status_body.dart';
import 'package:chat_app/features/status/presentation/views/widgets/status_view_appbar.dart';
import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StatusViewAppbar(),
      body: StatusBody());
  }
}