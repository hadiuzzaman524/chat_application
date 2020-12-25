import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // ignore: deprecated_member_use
      stream: Firestore.instance
          .collection('chat').orderBy('time',descending: true)
          .snapshots(),
      builder: (context, snapshoot) {
        if (snapshoot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshoot.hasData) {
          return ListView.builder(
            reverse: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      color: Colors.green,
                      child: Text(snapshoot.data.docs[index]['text'],style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),),
                    ),
                  ],
                ),
              );
            },
            itemCount: snapshoot.data.size,
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}
