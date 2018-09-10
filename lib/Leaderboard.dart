import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'LeaderBoardInstance.dart';
import 'dart:async';

class Leaderboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeaderboardState();
  }
}

class LeaderboardState extends State<Leaderboard> {
  var type;
  List leaderboards;
  List<LeaderBoardInstance> lis = [];
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
              Navigator.pop(context);
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

  @override
  void initState() {
    Stream<QuerySnapshot> s =
        Firestore.instance.collection("leaderboard").snapshots();
    s.listen((querySnapshot) =>
        querySnapshot.documents.forEach((doc) => print(doc["title"])));
    s.listen((querySnapshot) {
      List<DocumentSnapshot> docs = querySnapshot.documents;
      print(docs.length);
      querySnapshot.documents.forEach((doc)
          {
            String leaderBoardData = doc['complexobject'];
            leaderboards = json.decode(leaderBoardData);
            //print(leaderboards);
            lis.clear();
            for (Map<String, dynamic> leaderboard in leaderboards) {
              LeaderBoardInstance li = LeaderBoardInstance.fromJson(leaderboard);
              lis.add(li);
            }
            setState(() {

            });
          });


    });
    super.initState();
  }

  getDropdownItemsAsync() {
    List<DropdownMenuItem<String>> lidms = [];
    for (LeaderBoardInstance li in lis) {
      //print(li.allStudentRanks);
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
          margin: EdgeInsets.only(top: 16.0, right: 10.0),
          child: DropdownButton(
            isDense: true,
            hint: getStyle(),
            items: lidms,
            onChanged: (value) {
              selected = value;
              setState(() {});
            },
          ),
        ));
  }

  getLeaderboardNew() {
    if (lis.length == 0)
      return Text('loading...');
    else {
      LeaderBoardInstance selectedLeaderBoardInstance = null;
      for (LeaderBoardInstance li in lis) {
        if (li.name == selected) {
          selectedLeaderBoardInstance = li;
          break;
        }
      }
      if (selectedLeaderBoardInstance != null) {
        //fetch the selected value and change the xcodew accordingly
        List<AllStudentRank> asr =
            selectedLeaderBoardInstance.allStudentRanks.allStudentRanks;
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      asr[index].imageURL,
                      height: 30.0,
                    ),
                    title: Text(asr[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 30.0),
                          child: Text(asr[index].batchRank.toString()),
                        ),
                        Container(
                          child: Text(asr[index].points.toString()),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Divider(height: 3.0, color: Colors.black),
                  )
                ],
              ),
          itemCount: asr.length,
        );
      } else {
        return Text('loading...');
      }
    }
  }
}
