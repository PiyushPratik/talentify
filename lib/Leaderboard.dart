import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'LeaderBoardInstance.dart';

class Leaderboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeaderboardState();
  }
}

class LeaderboardState extends State<Leaderboard> {
  var type;
  List<DropdownMenuItem<String>> list = [ ];
  String selected = 'All Roles';

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
          actions: <Widget>[getDropwodnItemsAsync()],
        ),
        body: getLeaderboardNew(),
      ),
    );
  }

  getDropwodnItemsAsync() {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("leaderboard").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return DropdownButton(
              items: list,
              value: selected,
              onChanged: (value) {
                selected = value;
                setState(() {});
              },
            );

          var length = snapshot.data.documents.length;
          print('Lenght >>>>>> $length');
          DocumentSnapshot ds = snapshot.data.documents[length - 1];
          String leaderBoardData = ds['complexobject'];
          List leaderboards = json.decode(leaderBoardData);
          List<LeaderBoardInstance> lis = [];
          for (Map<String, dynamic> leaderboard in leaderboards) {
            LeaderBoardInstance li = LeaderBoardInstance.fromJson(leaderboard);
            lis.add(li);
          }
          List<DropdownMenuItem<String>> lidms = [];
          for (LeaderBoardInstance li in lis) {
            lidms.add(DropdownMenuItem(
              child: Text(li.name),
              value: li.name,
            ));
          }
          print('New list has now been pulled from firebase $lidms');

          print('Leaderboard type is >>>>>>>>>' +
              leaderboards[0].runtimeType.toString());
          return DropdownButton(
            items: lidms,
            value: selected,
            onChanged: (value) {
              selected = value;
              setState(() {});
            },
          );
          /*return new DropdownButton(
              items: snapshot.data.documents.map((DocumentSnapshot document) {
                return DropdownMenuItem(child: new Text(document.documentID));
              }).toList(),
              onChanged: (dynamic) {},
              hint: new Text("Join a Team"),
              value: 'na');*/
        });
  }

  getLeaderboardNew() {
    return new ListView(
      children: <Widget>[
        ListTile(
          title: Text('Something'),
        )
      ],
    );
  }

  getLeaderboard() {
    return StreamBuilder(
        stream: Firestore.instance.collection('leaderboard').snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.hasData);
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot board = snapshot.data.documents[index];
                var complexobjectString = board.data['complexobject'];
                print(complexobjectString);
                /*

                List<Map<String, dynamic>> jsons =
                    jsonDecode(complexobjectString);
                List<LeaderBoardInstance> string = [];
                for (Map<String, dynamic> json in jsons) {
                  string.add(LeaderBoardInstance.fromJson(json));
                }

                print('$string');
                for (var i = 0; i < string.length; i++) {
                  print('Item->' + string[i].toString());
                }
                //var points=string['userPoints'];*/
                //var points=string['userPoints'];*/
              });
        });
  }
}
