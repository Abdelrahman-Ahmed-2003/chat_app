import 'package:flutter/material.dart';
import 'muted_status.dart'; // Assuming this is the correct path to MutedStatus widget

class MutedBody extends StatefulWidget {
  const MutedBody({super.key});

  @override
  State<MutedBody> createState() => _MutedBodyState();
}

class _MutedBodyState extends State<MutedBody> {
  Icon arrowIcon = const Icon(Icons.keyboard_arrow_left);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Muted Status',
                style: TextStyle(color: Colors.grey),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    // Compare by icon data instead of Icon widget
                    if (arrowIcon.icon == Icons.keyboard_arrow_left) {
                      arrowIcon = const Icon(Icons.keyboard_arrow_down_outlined);
                    } else {
                      arrowIcon = const Icon(Icons.keyboard_arrow_left);
                    }
                  });
                },
                icon: arrowIcon,
              ),
            ],
          ),
        ),
        // Show MutedStatus based on icon value
        arrowIcon.icon == Icons.keyboard_arrow_down_outlined 
            ? const MutedStatus() 
            : Container(),
      ],
    );
  }
}
