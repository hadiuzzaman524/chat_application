import 'package:flutter/material.dart';
import '../widgets/signup_design.dart';
import '../widgets/login_design.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/AuthScreen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _sign = false;
  bool _log = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.amber[50],
            Colors.amber[100],
            Colors.amber[200],
            Colors.amber[100],
            Colors.amber[50],
          ]),
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            _sign
                ? SignupDesign(
                    create: _toogleSignUp,
                  )
                : LogInDesign(
                    create: _toggleLogIn,
                  ),
          ],
        ),
      ),
    );
  }
}
