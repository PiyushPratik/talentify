import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class chatbot extends StatelessWidget {
  final myController = TextEditingController();
  var _query, _key;
  @override
//  void dispose() {
//    myController.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Image
                  .network('http://business.talentify.in/course_images/AI.png'),
              Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 90.0),
                  child: Text('Zoya'),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text('Always available for you',
                      style: TextStyle(fontSize: 14.0)),
                )
              ])
            ],
          ),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.volume_up,
                ))
          ],
        ),
        body: Container(
            margin: EdgeInsets.only(
                top: 540.0, bottom: 10.0, left: 20.0, right: 100.0),
            child: TextField(
              controller: myController,
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              return response();
            },
          ),
        ),
      ),
    );
  }

  void response() {
      print('hello');
      post('http://business.talentify.in:9090/ai/simple-ai',
          body: {"query": _query, "key":_key}).then((response) async {
        var statusCode = response.statusCode;
        var body = response.body;
        var bodyObj = jsonDecode(body);
        print('statusCode:$statusCode>>>body:$body');
        print('Network call succeeded with body:$body');
      });
    }
  }
