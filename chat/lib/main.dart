import 'package:chat/model/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/auth.dart';
import './screens/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Colors.lightGreen, // status bar color
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MessageProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        fontFamily: 'Merriweather',
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, stateSnapshoot) {
          if (stateSnapshoot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (stateSnapshoot.hasData) {
            return MainScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
      routes: {
        AuthScreen.routeName: (context) => AuthScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
    );
  }
}
