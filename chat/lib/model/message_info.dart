import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageInformation {
  final String imageUrl;
  final String receiverId;
  final String senderId;
  final String text;
  final bool isMe;
  final Timestamp timestamp;
  final String userName;

  MessageInformation(
      {@required this.timestamp,
      @required this.isMe,
      @required this.imageUrl,
      @required this.receiverId,
      @required this.senderId,
      @required this.userName,
      @required this.text});
}
