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
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'easyChat',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontFamily: 'LobsterTwo'),
          ),
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
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Chats'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Contacts'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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
        ),
        drawer: Drawer(),
      ),
    );
  }
}
