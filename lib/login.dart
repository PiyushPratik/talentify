import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(){
  runApp(Login()) ;
}

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Loginstate();
  }
}

class Loginstate extends State<Login>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _obscureText = true;
  bool _showErrorLabel = false;
  double screenHeight, screenWidth;
  String _password, _email;
  void callLogin() async {
    Navigator.push(context,MaterialPageRoute(builder: (context) {
        return Text('hello');//DashBoard();
      }),
    );
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      print('Invalid form');
    } else {
      form.save();
      print('Handle login for email:$_email and password:$_password');
      post('http://192.168.1.7:8080/flutter-firebase/Authentication',
          body: {"email": _email, "password": _password}).then((response) {
        var statusCode = response.statusCode;
        var body = response.body;
        var bodyObj = jsonDecode(body);
        print('statusCode:$statusCode>>>body:$body');
        print('Network call succeeded with body:$body');
        var token = bodyObj['token'];
        var id = bodyObj['id'];
        print('token:$token>>>userId:$id');
        Navigator.push(context,MaterialPageRoute(builder: (context) {
            return Text('Flutter App');//dashboard();
          }),
        );
        Firestore.instance
            .collection('198104')
            .document('7QzUrFByFWxxoe0reuKk')
            .get()
            .then((onValue) {
          print('Done');
          print(onValue.data);
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
          Text('hello',style: TextStyle(color: Colors.red),),
      ),
    );
  }
}