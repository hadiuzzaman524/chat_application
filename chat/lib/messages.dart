import 'package:chat/widgets/messagebubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/message_info.dart';

class Messages extends StatefulWidget {
  final String receiverId;

  Messages({this.receiverId});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
          List<MessageInformation> _messageList = [];

          for (int i = 0; i < snapshoot.data.size; i++) {
            try {
              if (widget.receiverId == snapshoot.data.docs[i]['receiverId'] &&
                  uid == snapshoot.data.docs[i]['senderId']) {
                _messageList.add(MessageInformation(
                    timestamp: snapshoot.data.docs[i]['time'],
                    imageUrl: snapshoot.data.docs[i]['imageUrl'],
                    receiverId: snapshoot.data.docs[i]['receiverId'],
                    senderId: snapshoot.data.docs[i]['senderId'],
                    isMe: true,
                    userName: snapshoot.data.docs[i]['userName'],
                    text: snapshoot.data.docs[i]['text']));
              } else if (widget.receiverId ==
                      snapshoot.data.docs[i]['senderId'] &&
                  uid == snapshoot.data.docs[i]['receiverId']) {
                _messageList.add(MessageInformation(
                    timestamp: snapshoot.data.docs[i]['time'],
                    imageUrl: snapshoot.data.docs[i]['imageUrl'],
                    receiverId: snapshoot.data.docs[i]['receiverId'],
                    senderId: snapshoot.data.docs[i]['senderId'],
                    isMe: false,
                    userName: snapshoot.data.docs[i]['userName'],
                    text: snapshoot.data.docs[i]['text']));
              }
            } catch (e) {
              print('handle');
            }
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return _messageList[index].isMe
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: MessageBubble(
                          msg: _messageList[index].text,
                          isMe: true,
                          name: _messageList[index].userName,
                          imageUrl: _messageList[index].imageUrl,
                          time: _messageList[index].timestamp,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: MessageBubble(
                          msg: _messageList[index].text,
                          isMe: false,
                          name: _messageList[index].userName,
                          imageUrl: _messageList[index].imageUrl,
                          time: _messageList[index].timestamp,
                        ),
                      );
              },
              itemCount: _messageList.length,
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}

/*


 */
