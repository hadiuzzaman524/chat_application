import 'package:flutter/material.dart';
import '../screens/chat.dart';

class SignupDesign extends StatefulWidget {
  final Function create;
  final Function accountCreate;

  SignupDesign({this.create, this.accountCreate});

  @override
  _SignupDesignState createState() => _SignupDesignState();
}

class _SignupDesignState extends State<SignupDesign> {
  final _formKey = GlobalKey<FormState>();
  var _passwordFocus = FocusNode();
  var _confirmPasswordFocus = FocusNode();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _nameController=TextEditingController();
  var _emailFocus=FocusNode();
  String _password;

  _saveForm() {
    _formKey.currentState.save();
    bool valid = _formKey.currentState.validate();
    if (valid) {
      print("valid");
      //  Navigator.pushNamed(context, ChatScreen.routeName);
      widget.accountCreate(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          isLogin: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 400,
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 40,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  border: OutlineInputBorder(
                    gapPadding: 10,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    borderSide: BorderSide(width: 2.0, color: Colors.amber),
                  ),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please enter your email address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _emailController,
                focusNode: _emailFocus,
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
                    borderSide: BorderSide(width: 2.0, color: Colors.amber),
                  ),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please enter your email address';
                  } else if (!value.endsWith('.com')) {
                    return 'please enter valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                focusNode: _passwordFocus,
                controller: _passwordController,
                textInputAction: TextInputAction.next,
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
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                },
                onChanged: (value) {
                  _password = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be in 6 character long';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                focusNode: _confirmPasswordFocus,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  labelText: 'Confirm Password',
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
                    return 'please enter your password';
                  } else if (value.length < 6) {
                    return 'password must be in 6 character long';
                  } else if (value != _password) {
                    return 'password should not be match';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed: _saveForm,
                child: Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
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
                  'Already have an account? Log In ',
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
