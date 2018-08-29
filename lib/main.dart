import 'package:flutter/material.dart';
import 'package:talentify/login.dart';

void main() {
  runApp(home());
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<Homescreen> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            body: new Container(
                color: Colors.white,
                child: new Column(children: <Widget>[
                  new Container(
                      height: ((screenHeight * 70) / 100),
                      color: Colors.white,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Divider(height: 30.0, color: Colors.white),
                          new SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: Image
                                  .asset('assets/images/talentify_logo.png')),
                          new Divider(height: screenHeight * 0.059, color: Colors.white),
                          new Text("TALENTIFY",
                              style: new TextStyle(
                                  color: Color.fromRGBO(165, 165, 165, 10.0),
                                  fontSize: 22.0,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold))
                        ],
                      )),
                  Container(
                      height: ((screenHeight * 30) / 100),
                      //margin: EdgeInsets.only(top: 160.0),
                      color: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                width: screenWidth * .82,
                                height: 45.0,
                                //color: Colors.yellow,
                                child: new RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(24.0)),
                                    onPressed: () => handleLogin(true),
                                    elevation: 5.0,
                                    color: Color.fromRGBO(235, 56, 79, 10.0),
                                    textColor: Colors.white,
                                    child: new Text(
                                      'LOG IN',
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            new Divider(height: screenHeight *0.039, color: Colors.white),
                            new GestureDetector(
                                onTap: () => handleLogin(false),
                                child: new Text("Sign Up",
                                    style: new TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.normal))),
                            new Divider(height: screenHeight *0.037, color: Colors.white),
                          ]))
                ]))));
  }

  void handleLogin(bool isLoginRequired) {
    print('Send to the login screen now $isLoginRequired');
    if (isLoginRequired == true)
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
  }
}
