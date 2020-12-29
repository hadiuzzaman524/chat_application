import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier{

  List<String> _userList;
  Future<void> getuniqueUser() async{

    final uid=FirebaseAuth.instance.currentUser.uid;
    final snapshoot=await Firestore.instance
        .collection('chat').get();
    print(snapshoot.size);


    print(snapshoot.docs[2]['text']);
    print(_userList);
    notifyListeners();
  }

}