import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isMe;

  MessageBubble({this.msg, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
         
          decoration: BoxDecoration(
            color: isMe ? Colors.red : Colors.green,
            borderRadius:isMe?BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10)):BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10))
          ),
          child: Text(
            msg,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
