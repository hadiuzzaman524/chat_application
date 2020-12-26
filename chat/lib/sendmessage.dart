import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  String _typedMessage = '';
  var textController=TextEditingController();

  _sendMessage() async{
    final user=await FirebaseAuth.instance.currentUser.uid;
    int i=0;
    DocumentSnapshot userName= await FirebaseFirestore.instance.collection('users').doc(user).get();
    final x= userName.data()['name'];


   await FirebaseFirestore.instance.collection('chat').add({
      'text': _typedMessage,
     'time': Timestamp.now(),
     'userId':user,
     'userName':x,
    });
    textController.clear();
  }

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
                style: TextStyle(
                  fontSize: 17,
                ),
                onChanged: (value) {
                  setState(() {
                    _typedMessage = value;
                  });

                },
                onSubmitted: (_){
                  _sendMessage();
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _typedMessage.trim().length<1 ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
