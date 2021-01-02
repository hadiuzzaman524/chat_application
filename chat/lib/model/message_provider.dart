import 'package:chat/model/message_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageProvider with ChangeNotifier {
  Stream<List<MessageInformation>> get getLastMsg {
    return FirebaseFirestore.instance
        .collection('chat')
        .orderBy('time', descending: true)
        .snapshots()
        .map(_currentShapshoot);
  }

  List<MessageInformation> _currentShapshoot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      print(e.data()['text']);
      return MessageInformation(timestamp:e.data()['time'],
          isMe: e.data()['isMe'],
          imageUrl: e.data()['imageUrl'],
          receiverId: e.data()['receiverId'],
          senderId: e.data()['senderId'],
          userName: e.data()['userName'],
          text: e.data()['text']);
    }).toList();


  }
}
