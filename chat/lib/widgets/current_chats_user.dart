import 'package:chat/model/user_info.dart';
import 'package:chat/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat.dart';
import 'package:provider/provider.dart';

class CurrentChat extends StatelessWidget {
  _chatPage(BuildContext ctx, String userId) {
    Navigator.pushNamed(ctx, ChatScreen.routeName, arguments: userId);
  }

  @override
  Widget build(BuildContext context) {
    //final v=Provider.of<UserProvider>(context).getuniqueUser();

    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (ctx, snapshoot) {
          if (snapshoot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('chat').snapshots(),
            builder: (ctx, snp) {
              final userId = FirebaseAuth.instance.currentUser.uid;
              if (snp.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<String> _userList = [];
              for (int i = 0; i < snp.data.size; i++) {
                if (userId == snp.data.docs[i]['senderId']) {
                  _userList.add(snp.data.docs[i]['receiverId']);
                }

                if (userId == snp.data.docs[i]['receiverId']) {
                  _userList.add(snp.data.docs[i]['senderId']);
                }
              }
              _userList = _userList.toSet().toList();
              print(_userList);

              List<UsrList> _chatUser = [];

              for (int i = 0; i < _userList.length; i++) {
                for (int j = 0; j < snapshoot.data.size; j++) {
                  if (_userList[i] == snapshoot.data.docs[j]['userId']) {
                    _chatUser.add(UsrList(
                      name: snapshoot.data.docs[j]['name'],
                      imageUrl: snapshoot.data.docs[j]['imageUrl'],
                      userId: snapshoot.data.docs[j]['userId'],
                    ));
                  }
                }
              }
              // print(_chatUser.length);

              return ListView.builder(
                itemBuilder: (ctx, ind) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: (){
                            _chatPage(context,_chatUser[ind].userId);
                          },
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(_chatUser[ind].imageUrl),
                          ),
                          title: Text(
                            _chatUser[ind].name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('nothing to show...'),
                        ),
                        Divider(height: 2,),
                      ],
                    ),
                  );
                  // return Text('${_chatUser[ind].name}');
                },
                itemCount: _chatUser.length,
              );
            },
          );
          // return Text('${snapshoot.data.size}');
        });
  }
}

/*
 List<String> _userList = [];
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('chat')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          final userId = FirebaseAuth.instance.currentUser.uid;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          for(int i=0; i<snapshot.data.size; i++){
            _userList.add(snapshot.data.docs[i]['senderId']);
          }
          _userList=_userList.toSet().toList();

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot2) {
              if(snapshot2.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  for(int j=0; j<_userList.length; j++){
                    if(_userList[j]==snapshot2.data.docs[index]['userId']&&userId!=snapshot2.data.docs[index]['userId']){
                      return Column(
                        children: [
                          ListTile(
                            onTap: (){
                              _chatPage(ctx, snapshot2.data.docs[index]['userId']);
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot2.data.docs[index]['imageUrl']),
                            ),
                            title: Text(snapshot2.data.docs[index]['name'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),),
                            subtitle: Text('Nothing...'),
                          ),
                          Divider(),
                        ],
                      );
                    }

                  }
                  return null;
                },
                itemCount:snapshot2.data.size,
              );
            }
          );
        });

 */