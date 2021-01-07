import 'dart:io';

import 'package:chat/model/message_info.dart';
import '../widgets/contact_list.dart';
import '../model/user_info.dart';
import 'package:chat/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/search_contact.dart';

class UserContacts extends StatelessWidget {
  _chatPage(BuildContext ctx, String userId, String name, String imageUrl) {
    Navigator.pushNamed(ctx, ChatScreen.routeName,
        arguments: [userId, name, imageUrl]);
  }

  List<UsrList> usrInfo = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showSearch(
              context: context,
              delegate: SearchContact(userList: usrInfo, chatPage: _chatPage),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffededed),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton.icon(
                  icon: Icon(Icons.search),
                  onPressed: null,
                  label: Text(''),
                ),
                Text(
                  'Search...',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshoot) {
                if (snapshoot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<UsrList> _usersInfo = [];
                for (int i = 0; i < snapshoot.data.size; i++) {
                  if (snapshoot.data.docs[i]['userId'] !=
                      FirebaseAuth.instance.currentUser.uid) {
                    _usersInfo.add(UsrList(
                        name: snapshoot.data.docs[i]['name'],
                        imageUrl: snapshoot.data.docs[i]['imageUrl'],
                        userId: snapshoot.data.docs[i]['userId']));
                  }
                }
                usrInfo = _usersInfo;
                return ContactList(
                  usersInfo: _usersInfo,
                  chatPage: _chatPage,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
