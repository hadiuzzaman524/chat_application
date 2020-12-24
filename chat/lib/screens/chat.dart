import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // ignore: deprecated_member_use
              stream: Firestore.instance
                  .collection('chats/qg9zAvl4VbAcZ56odH7J/msg')
                  .snapshots(),
              builder: (ctx, snapShoot) {
                return snapShoot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return Text(snapShoot.data.docs[index]['text']);
                        },
                        itemCount: snapShoot.data.size,
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.expand_less),
        onPressed: () {
          // ignore: deprecated_member_use
          Firestore.instance.collection('chats/qg9zAvl4VbAcZ56odH7J/msg').add({
            'text': 'my name is hadiuzzaman',
          });
        },
      ),
    );
  }
}
