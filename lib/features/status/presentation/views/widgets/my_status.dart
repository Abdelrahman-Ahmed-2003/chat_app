import 'package:flutter/material.dart';

class MyStatus extends StatelessWidget {
  const MyStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/marwan.jpg'),
          ),
          Positioned(
            bottom: 0,
            right: 1,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      title: const Text('My Status'),
      subtitle: const Row(
        children: [
          Icon(Icons.done_all, color: Colors.blueGrey, size: 20),
          SizedBox(width: 5),
          Text(
            'Tap to add status update',
            style: TextStyle(color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}
