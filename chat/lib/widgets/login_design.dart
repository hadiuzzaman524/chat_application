import 'package:flutter/material.dart';

class LogInDesign extends StatefulWidget {
  final Function create;

  LogInDesign({this.create});

  @override
  _LogInDesignState createState() => _LogInDesignState();
}

class _LogInDesignState extends State<LogInDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 400,
      width: double.infinity,
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
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
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
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
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                onPressed: () {},
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
