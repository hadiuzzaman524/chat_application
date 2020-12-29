import 'dart:ffi';

import 'package:chat/widgets/messagebubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  final String receiverId;

  Messages({this.receiverId});

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
          if (snapshoot.hasData) /**/ {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),

              child: ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  if (receiverId==snapshoot.data.docs[index]['receiverId']&&uid == snapshoot.data.docs[index]['senderId']) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: MessageBubble(
                        msg: snapshoot.data.docs[index]['text'],
                        isMe: true,
                        name: snapshoot.data.docs[index]['userName'],
                        imageUrl: snapshoot.data.docs[index]['imageUrl'],
                      ),
                    );
                  }
                  else if (receiverId==snapshoot.data.docs[index]['senderId']&&uid == snapshoot.data.docs[index]['receiverId']) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: MessageBubble(
                        msg: snapshoot.data.docs[index]['text'],
                        isMe: false,
                        name: snapshoot.data.docs[index]['userName'],
                        imageUrl: snapshoot.data.docs[index]['imageUrl'],
                      ),
                    );
                  }

                  return null;
                },
                itemCount: snapshoot.data.size,
              ),
            );
          } else {
            return Text('Loading...');
          }
        });
  }
}
