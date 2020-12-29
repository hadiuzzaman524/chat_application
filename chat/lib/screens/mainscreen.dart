import 'package:flutter/material.dart';
import '../widgets/all_contacts.dart';
import '../widgets/current_chats_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/MainScreen';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              DropdownButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Log Out'),
                    value: 'logout',
                  ),
                ],
                onChanged: (String value) {
                  if (value == 'logout') {
                    FirebaseAuth.instance.signOut();
                  }
                },
              )
            ],
            bottom: TabBar(
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Chats',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Contacts',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CurrentChat(),
              UserContacts(),

            ],
          )),
    );
  }
}
