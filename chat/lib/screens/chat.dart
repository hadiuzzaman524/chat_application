import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routeName='/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context,index){
              return Text("Love u mantasha");
            },
            itemCount: 10,),
          ),
        ],
      ),
    );
  }
}
