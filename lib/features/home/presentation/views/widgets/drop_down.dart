import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        // Handle the selected menu item
        print(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          onTap: () {
            //Navigator.push(
                //context, MaterialPageRoute(builder: (context) => Profile()));
          },
          value: 'Option 1',
          child: const Text('Profile'),
        ),
      ],
      icon: const Icon(Icons.more_vert),
    );
  }
}
