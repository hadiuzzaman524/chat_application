import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_info.dart';

class ContactList extends StatelessWidget {
   List<UsrList> usersInfo;
  final Function(
          BuildContext context, String userId, String name, String imageUrl)
      chatPage;

  ContactList({this.usersInfo, this.chatPage});


  @override
  Widget build(BuildContext context) {
    return Container(
      child:usersInfo.isEmpty? Center(child: Text('No result found'),): ListView.builder(
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(usersInfo[index].imageUrl),
                ),
                title: Text(
                  usersInfo[index].name,
                ),
                onTap: () {
                  String userId = usersInfo[index].userId;
                  chatPage(context, userId, usersInfo[index].name,
                      usersInfo[index].imageUrl);
                },
              ),
              Divider(
                height: 1,
              ),
            ],
          );
        },
        itemCount: usersInfo.length,
      ),
    );
  }
}
