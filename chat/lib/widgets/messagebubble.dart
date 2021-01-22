import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isMe;
  final String name;
  final String imageUrl;
  final Timestamp time;

  MessageBubble({this.msg, this.isMe, this.name, this.imageUrl, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 15,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
              color: isMe ? Color(0xffDCF8C5) : Colors.white,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3,
              ),
              Container(
                width: msg.length <= 5
                    ? 45
                    : msg.length < 20 && msg.length > 5
                        ? 100
                        : msg.length < 30 && msg.length > 20
                            ? 150
                            : 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
             /*           Text(
                          '${DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch).hour.toString()}' +
                              '${DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch).minute.toString()}',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        ),*/
                      ],
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      msg,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: isMe ? Colors.black : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
