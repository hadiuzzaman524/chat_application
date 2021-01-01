import 'package:flutter/material.dart';
import '../screens/chat.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:toast/toast.dart';

class SignupDesign extends StatefulWidget {
  final Function create;
  final Function(
      {String email,
      String password,
      String name,
      bool isLogin,
      File image}) accountCreate;

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
  var _nameController = TextEditingController();
  var _emailFocus = FocusNode();
  String _password;
  File _image;

  _pickedImage() async {
    final img = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      if (img != null) {
        _image = File(img.path);
      }
    });
  }

  _saveForm(BuildContext context) {
    _formKey.currentState.save();
    bool valid = _formKey.currentState.validate();
    if (valid&&_image!=null) {

      //  Navigator.pushNamed(context, ChatScreen.routeName);
      widget.accountCreate(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          isLogin: false,
          image: _image);
    }
    else{
      _showToastMsg(context);
    }
  }
  _showToastMsg(BuildContext context){
    Scaffold.of(context).showSnackBar(SnackBar(

        content: Container(
          child: Text('Please picked a image',style: TextStyle(
              color: Colors.white,

          ),textAlign: TextAlign.center,),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
     
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickedImage,
                child: CircleAvatar(
                  backgroundImage: _image != null ? FileImage(_image) : null,
                  backgroundColor: Colors.white,
                  child: _image == null ? Icon(Icons.image) : null,
                  radius: 40,
                ),
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
                  _saveForm(context);
                },
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed:(){
                  _saveForm(context);
                },
                child: Container(

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 45,
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
