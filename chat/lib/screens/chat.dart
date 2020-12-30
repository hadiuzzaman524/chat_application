import 'package:chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:chat/sendmessage.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/ChatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context).settings.arguments as List<String>;
    final receiverId = list[0];
    final name = list[1];
    final imageUrl = list[2];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //video call
                  }),
              IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //audio call
                  }),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/chat.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
              child: Messages(receiverId: receiverId),
            ),
            SendMessage(
              receiverId: receiverId,
            ),
          ],
        ),
      ),
    );
  }
}
