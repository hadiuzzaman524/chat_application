import 'package:chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/sendmessage.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        centerTitle: true,
        actions: [
          DropdownButton(
            icon: Icon(Icons.list,color: Colors.white,),
            items: [
              DropdownMenuItem(
                child: Text('Log Out'),
                value: 'logout',
              ),
            ], onChanged: (String value) {
              if(value=='logout'){
                FirebaseAuth.instance.signOut();
              }
          },
          )
        ],
      ),
      body: Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image:AssetImage('assets/images/chat.png'),
           fit: BoxFit.cover,
         )
       ),
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            SendMessage(),
          ],
        ),
      ),
    );
  }
}
