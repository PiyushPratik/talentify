import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:talentify/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _obscureText = true;
  bool _showErrorLabel = false;
  double screenHeight, screenWidth;
  String _password, _email;
  void callLogin() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      print('Invalid form');
    } else {
      form.save();
      print('Handle login for email:$_email and password:$_password');
      post('http://business.talentify.in:9090/flutter-firebase/Authentication',
              body: {"email": _email, "password": _password})
          .then((response) async {
        var statusCode = response.statusCode;
        var body = response.body;
        var bodyObj = jsonDecode(body);
        print('statusCode:$statusCode>>>body:$body');
        print('Network call succeeded with body:$body');
        var token = bodyObj['token'];
        var id = bodyObj['id'];
        var value = int.parse(id);
        // print((value is int));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('key', value);
        var msg = bodyObj['msg'];
        //print('$msg');
        print('token:$token>>>id:$id');
        String success = 'Success';
        if (bodyObj['msg'] == success) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return dashboard();
            }),
          );
        } else {
          print('$msg');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        //key: scaffoldState,
        body: new Container(
            child: new Theme(
                data: new ThemeData(
                    primaryColor: Colors.red,
                    accentColor: Colors.orange,
                    hintColor: Colors.grey),
                child: new ListView(
                  physics: new NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 30.0),
                      constraints: new BoxConstraints.expand(height: 640.0),
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Divider(
                            height: screenHeight * 0.1,
                            color: Colors.white,
                          ),
                          new Text("Welcome back! Ready to get some work done?",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              )),
                          new Divider(
                            color: Colors.white,
                            height: screenHeight * 0.03,
                          ),
                          new Form(
                              key: _formKey,
                              child: new Column(children: [
                                new TextFormField(
                                    maxLines: 1,
                                    keyboardType: TextInputType
                                        .emailAddress, // Use email input type for emails.

                                    onSaved: (val) => _email = val,
                                    validator: (val) =>
                                        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                                .hasMatch(val)
                                            ? 'Not a valid email.'
                                            : null,
                                    decoration: new InputDecoration(
                                        hintText: 'Email ID',
                                        border: new OutlineInputBorder())),
                                new Divider(
                                  color: Colors.white,
                                  height: screenHeight * 0.03,
                                ),
                                new TextFormField(
                                  obscureText: _obscureText,
                                  onSaved: (val) => _password = val,
                                  validator: (val) => val.length < 4
                                      ? 'Password too short.'
                                      : null,
                                  decoration: new InputDecoration(
                                    hintText: 'Password',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        print('_passwordToggle');
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: _obscureText
                                          ? const Icon(Icons.remove_red_eye,
                                              color: Colors.grey)
                                          : const Icon(Icons.remove_red_eye,
                                              color: Colors.red),
                                    ),
                                  ),
                                ),
                                _showErrorLabel
                                    ? new Container(
                                        width: screenWidth - 30,
                                        padding: const EdgeInsets.all(10.0),
                                        margin:
                                            const EdgeInsets.only(bottom: 10.0),
                                        color: Colors.red,
                                        child: new Text(
                                          '_errorText',
                                          textAlign: TextAlign.left,
                                          style: new TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.red),
                                        ),
                                      )
                                    : new Container(
                                        child: new Divider(
                                        color: Colors.white,
                                        height: screenHeight * 0.02,
                                      )),
                                new Container(
                                    width: screenWidth - 30,
                                    height: screenHeight * 0.07,
                                    child: new RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        onPressed: () {
                                          //ifFieldValid = validateFields();
                                          callLogin();
                                        },
                                        elevation: 5.0,
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        child: new Text(
                                          'LOG IN',
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                new Divider(
                                  color: Colors.transparent,
                                  height: screenHeight * 0.05,
                                ),
                                new RaisedButton(
                                    elevation: 0.0,
                                    textColor: Colors.grey,
                                    color: Colors.transparent,
                                    onPressed: () {},
                                    child: new Text(
                                      'Forgot password?',
                                      style: new TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal),
                                    )),
                                new Divider(
                                  color: Colors.transparent,
                                  height: screenHeight * 0.05,
                                ),
                                Text(
                                    'Not a member?Register instead',
                                    style: new TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                              ])),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
