import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessage extends StatefulWidget {
  final String receiverId;
  SendMessage({this.receiverId});
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  String _typedMessage = '';
  var textController = TextEditingController();
  String _sendMessageString;


  _sendMessage() async {
    setState(() {
      _sendMessageString=_typedMessage;
      _typedMessage='';
      textController.clear();
    });

    final user = await FirebaseAuth.instance.currentUser.uid;
    int i = 0;
    DocumentSnapshot userName =
        await FirebaseFirestore.instance.collection('users').doc(user).get();
    final x = userName.data()['name'];
    final imageUrl = userName.data()['imageUrl'];

    await FirebaseFirestore.instance.collection('chat').add({
      'text': _sendMessageString.trim(),
      'time': Timestamp.now(),
      'senderId': user,
      'userName': x,
      'imageUrl': imageUrl,
      'receiverId':widget.receiverId,
    });
    textController.clear();
  }

/*  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Type your message here...',
                ),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                style: TextStyle(
                  fontSize: 17,
                ),
                onChanged: (value) {
                  setState(() {
                    _typedMessage = value;
                  });
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _typedMessage.trim().length < 1 ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
