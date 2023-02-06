import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/chat/messages.dart';
import '../widget/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  // const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('U Chat'),
          backgroundColor: Color.fromARGB(255, 13, 22, 40),
          actions: [
            DropdownButton(
                dropdownColor: Colors.blueGrey,
                items: [
                  DropdownMenuItem(
                    value: 'logOut',
                    child: Container(
                      child: Row(children: const [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 10,
                        ),
                        Text('logOut')
                      ]),
                    ),
                  )
                ],
                onChanged: (itemIdentifire) {
                  if (itemIdentifire == 'logOut') {
                    FirebaseAuth.instance.signOut();
                  }
                })
          ]),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(221, 22, 31, 30),
          // image: DecorationImage(
          //     image: NetworkImage(
          //         'https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200911064223/bg.jpg'),
          //     fit: BoxFit.cover)
        ),
        child: Column(
          children: <Widget>[Expanded(child: Messages()), NewMessages()],
        ),
      ),
    );
  }
}
