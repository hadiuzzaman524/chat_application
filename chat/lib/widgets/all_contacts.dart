import 'dart:io';

import 'package:chat/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserContacts extends StatelessWidget {

  _chatPage(BuildContext ctx,String userId) {
    Navigator.pushNamed(ctx, ChatScreen.routeName,arguments: userId);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshoot) {
          if(snapshoot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  if(snapshoot.data.docs[index]['userId']!=FirebaseAuth.instance.currentUser.uid)ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(snapshoot.data.docs[index]['imageUrl']),
                    ),
                    title:Text(snapshoot.data.docs[index]['name'],style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),),
                    onTap: () {
                      String userId=snapshoot.data.docs[index]['userId'];
                      _chatPage(context,userId);
                    },
                    subtitle: Text('Nothing to say...'),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              );
            },
            itemCount: snapshoot.data.size,
          );
        },
      ),
    );
  }
}
