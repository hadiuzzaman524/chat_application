import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/signup_design.dart';
import '../widgets/login_design.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/AuthScreen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _sign = false;
  bool _log = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String errorMsg = '';
  bool isLoading = false;
  BuildContext cntx;

  _toogleSignUp() {
    setState(() {
      _sign = false;
      _log = true;
    });
  }

  _toggleLogIn() {
    setState(() {
      _sign = true;
      _log = false;
    });
  }

  _createOrLoginUser(
      {String email,
      String password,
      String name,
      bool isLogin,
      File image}) async {
    UserCredential state;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        state = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        //new add
        setState(() {
          isLoading = false;
        });
      } else {
        state = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //print(image.path);
        final bucket = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(state.user.uid + '.jpg');
        await bucket.putFile(image).whenComplete(() => null);
        final imageUrl = await bucket.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(state.user.uid)
            .set({
          'name': name,
          'email': email,
          'imageUrl': imageUrl,
          'userId': state.user.uid
        });
        //new added
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      errorMsg = error.toString();
      _displaySnackBar(cntx);
      //  Scaffold.of(cntx).showSnackBar(SnackBar(content: Text(errorMsg)));
      print("error:" + errorMsg);
      setState(() {
        isLoading = false;
      });
    }

  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Color(0xff293F63),
        content: Text(
      errorMsg,
      textAlign: TextAlign.center,
    ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    cntx = context;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffededed),
          /*  gradient: RadialGradient(
                colors: [
                  Colors.white54,
                  Color(0xff293F55),
                  Color(0xff293F63),
                ],
                radius: 1,
                stops: [
                  0.2,
                  0.8,
                  1
                ]),*/ /*LinearGradient(colors: [
              Colors.greenAccent,
              Colors.lightGreenAccent,
              Colors.greenAccent,
            ]),*/
          ),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    _sign
                        ? SignupDesign(
                            create: _toogleSignUp,
                            accountCreate: _createOrLoginUser,
                          )
                        : LogInDesign(
                            create: _toggleLogIn,
                            accountCreate: _createOrLoginUser,
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
