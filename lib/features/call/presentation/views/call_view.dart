import 'package:chat_app/features/call/presentation/views/widgets/call_body.dart';
import 'package:chat_app/features/call/presentation/views/widgets/call_view_appbar.dart';
import 'package:flutter/material.dart';

class CallView extends StatelessWidget {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CallViewAppbar(),
      body: CallBody(),
    );
  }
}