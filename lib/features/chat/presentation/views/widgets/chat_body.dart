import 'package:flutter/material.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print('User Message');
          },
          child: const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text('User Name'),
            subtitle: Row(
              children: [
                Icon(Icons.done_all, color: Colors.blueGrey, size: 20),
                SizedBox(width: 5),
                Text(
                  'This is the last message',
                  style: TextStyle(color: Colors.blueGrey),
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('10:00'),
                Flexible(
                    child: CircleAvatar(
                  radius: 13.0,
                  child: Text('2'),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
