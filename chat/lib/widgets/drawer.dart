import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.greenAccent,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
