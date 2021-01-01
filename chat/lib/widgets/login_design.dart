import 'package:flutter/material.dart';
import '../screens/chat.dart';


class LogInDesign extends StatefulWidget {
  final Function create;
  final Function accountCreate;

  LogInDesign({this.create, this.accountCreate});

  @override
  _LogInDesignState createState() => _LogInDesignState();
}

class _LogInDesignState extends State<LogInDesign> {
  final _formKey = GlobalKey<FormState>();
  var passwordFocus = FocusNode();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _saveInfo() {
    _formKey.currentState.save();
    bool valid = _formKey.currentState.validate();
    if (valid) {
      print(emailController.text);
      print(passwordController.text);
      //Navigator.pushNamed(context, ChatScreen.routeName);
      widget.accountCreate(
          email: emailController.text,
          password: passwordController.text,
          name: "",
          isLogin:true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 100),
      height: 400,
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.endsWith('.com')) {
                    return 'Please enter valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                focusNode: passwordFocus,
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 6) {
                    return 'Password must be in 6 character long';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  _saveInfo();
                },
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed: _saveInfo,
                child: Container(

                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Submit Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: widget.create,
                child: Text(
                  'Don\'t have an account? Create One! ',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
