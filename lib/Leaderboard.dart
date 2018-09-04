import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'LeaderBoardInstance.dart';
import 'dashboard.dart';

class Leaderboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeaderboardState();
  }
}

class LeaderboardState extends State<Leaderboard> {
  var type;
  List leaderboards;
  List<DropdownMenuItem<String>> list = [];
  String selected = 'All Roles';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 56, 79, 1.0),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return dashboard();
              }));
            },
          ),
          title: Text('Leaderboard'),
          actions: <Widget>[getDropdownItemsAsync()],
        ),
        body: getLeaderboardNew(),
      ),
    );
  }

  getStyle() {
    return new Text(
      selected,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17.0),
    );
  }

  getDropdownItemsAsync() {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("leaderboard").snapshots(),
        builder: (context, snapshot) {
          var length = snapshot.data.documents.length;
          //print('Lenght >>>>>> $length');
          DocumentSnapshot ds = snapshot.data.documents[length - 1];
          String leaderBoardData = ds['complexobject'];
          leaderboards = json.decode(leaderBoardData);
          //print(leaderboards);
          List<LeaderBoardInstance> lis = [];
          for (Map<String, dynamic> leaderboard in leaderboards) {
            LeaderBoardInstance li = LeaderBoardInstance.fromJson(leaderboard);
            lis.add(li);
          }
          List<DropdownMenuItem<String>> lidms = [];
          for (LeaderBoardInstance li in lis) {
            lidms.add(DropdownMenuItem(
              child: Text(
                li.name,
                style: TextStyle(color: Colors.black),
              ),
              value: li.name,
            ));
          }

          return Theme(
              data: ThemeData(
                  canvasColor: Colors.white, brightness: Brightness.values[0]),
              child: Container(
                margin: EdgeInsets.only(top: 17.0, right: 10.0),
                child: DropdownButton(
                  isDense: true,
                  hint: getStyle(),
                  items: lidms,
                  onChanged: (value) {
                    print(value);
                    selected = value;
                    setState(() {});
                  },
                ),
              ));
        });
  }

  getLeaderboardNew() {
    if (selected == 'Demo Content') {
      return getdemocontent();
    } else if (selected == 'All Roles') {
      return getallroles();
    }
  }

  getdemocontent() {
    return ListView(
      children: <Widget>[],
    );
  }

  getallroles() {
    return ListView(children: <Widget>[]);
  }
}
