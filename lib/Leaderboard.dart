import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Leaderboard extends StatelessWidget {
  var type;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 56, 79, 1.0),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Leaderboard'),
          actions: <Widget>[
            DropdownButton(items:null , onChanged: null)
          ],
        ),
        body: getLeaderboard(),
      ),
    );
  }

  getLeaderboard() {
    return StreamBuilder(
        stream: Firestore.instance.collection('leaderboard').snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.hasData);
          return PageView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot board = snapshot.data.documents[index];
                var complexobjectString = board.data['complexobject'];
               List<dynamic> string = json.decode(complexobjectString);
                print('$string');
                //var points=string['userPoints'];
              });
        });
  }
}
