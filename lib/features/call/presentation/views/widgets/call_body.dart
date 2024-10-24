import 'package:flutter/material.dart';

class CallBody extends StatelessWidget {
  const CallBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            
          },
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
              child: Icon(Icons.person,color: Colors.white,),
            ),
            title: const Text('User Name'),
            subtitle: const Text(
              'Today 12:00 PM',
              style: TextStyle(color: Colors.blueGrey),
            ),
            trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.call)),
          ),
        );
      },
    );
  }
}