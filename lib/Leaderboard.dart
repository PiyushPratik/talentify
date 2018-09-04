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
          actions: <Widget>[getDropdownItemsAsync1()],
        ),
        body: getLeaderboardNew(),
      ),
    );
  }

  var seletceeddd = 'All Roles';
  getDropdownItemsAsync1() {
    return Theme(
        data: ThemeData(
            canvasColor: Colors.white, brightness: Brightness.values[0]),
        child: DropdownButton(
          style: TextStyle(),
          hint: getStyle(),
          items: <DropdownMenuItem<String>>[
            new DropdownMenuItem(
                child: Text('one', style: TextStyle(color: Colors.black)),
                value: 'one'),
            new DropdownMenuItem(
                child: new Text('two', style: TextStyle(color: Colors.black)),
                value: 'two'),
          ],
          onChanged: (value) {
            print(value);
            seletceeddd = value;
            setState(() {});
          },
        ));
  }

  getStyle() {
    return new Text(
      seletceeddd,
      style: TextStyle(color: Colors.white),
    );
  }

  getDropdownItemsAsync() {
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("leaderboard").snapshots(),
        builder: (context, snapshot) {
//          if (!snapshot.hasData)
//            return DropdownButton(
//              items: list,
//              value: selected,
//              onChanged: (value) {
//                selected = value;
//                setState(() {});
//              },
//            );

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
                style: TextStyle(color: Colors.white),
              ),
              value: li.name,
            ));
          }
//         print('New list has now been pulled from firebase $lidms');
//
//          print('Leaderboard type is >>>>>>>>>' +
//              leaderboards[0].runtimeType.toString());
          return Container(
            margin: EdgeInsets.only(right: 15.0, top: 16.0),
            child: DropdownButton(
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
              isDense: true,
              items: lidms,
              value: selected,
              onChanged: (value) {
                selected = value;
                setState(() {});
              },
            ),
          );
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
