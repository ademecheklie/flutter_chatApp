import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './message_bubles.dart';

class Messages extends StatelessWidget {
  //const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(
          FirebaseAuth.instance.currentUser,
        ),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder (
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const Center(child: CircularProgressIndicator());
                }
                final snapChats = snapshot.data?.docs;

                return ListView.builder(
                    reverse: true,
                    itemCount: snapChats?.length,
                    itemBuilder: (ctx, index) => MessageBubles(
                        snapChats[index]['text'],
                        snapChats[index]['username'],
                        snapChats[index]['imageUrl'],
                        snapChats[index]['userId'] == futureSnapshot.data.uid,
                        kkey: ValueKey(snapChats[index].id)));
              });
        });
  }
}
