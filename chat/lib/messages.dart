import 'package:chat/widgets/messagebubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // ignore: deprecated_member_use
      stream: Firestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshoot) {
        final uid = FirebaseAuth.instance.currentUser.uid;
        if (snapshoot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshoot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: MessageBubble(
                    msg: snapshoot.data.docs[index]['text'],
                    isMe: snapshoot.data.docs[index]['userId'] == uid,
                    name: snapshoot.data.docs[index]['userName'],
                    imageUrl:snapshoot.data.docs[index]['imageUrl'],
                  ),
                );
              },
              itemCount: snapshoot.data.size,
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}
