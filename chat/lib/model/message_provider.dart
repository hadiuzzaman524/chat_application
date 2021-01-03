import 'package:chat/model/message_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageProvider with ChangeNotifier {
  final userId = FirebaseAuth.instance.currentUser.uid;

  get getLastMsg async {
    List<String> _idList = [];
    final response = await FirebaseFirestore.instance.collection('chat').get();
    _idList = response.docs.map((e) {
      return e.id;
    }).toList();

    List<String> _userList = [];
    List<Map<String, dynamic>> messageI = [];

    for (int i = 0; i < _idList.length; i++) {
      final resp = await FirebaseFirestore.instance
          .collection('chat')
          .doc(_idList[i].toString()).get();
      final tempVal = resp.data() as Map<String, dynamic>;
      messageI.add(tempVal);
    }

  }
}
