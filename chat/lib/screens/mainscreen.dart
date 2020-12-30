import 'package:flutter/material.dart';
import '../widgets/all_contacts.dart';
import '../widgets/current_chats_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/drawer.dart';

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

          bottom: TabBar(
            indicatorColor: Colors.greenAccent,

            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Chats'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,

                      ),
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
        drawer: Drawer(
          child: DrawerDesign(
          ),
        ),
      ),
    );
  }
}
