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
      //List<DocumentSnapshot> docs = querySnapshot.documents;
      querySnapshot.documents.forEach((doc) {
        String leaderBoardData = doc['complexobject'];
        leaderboards = json.decode(leaderBoardData);
        lis.clear();
        for (Map<String, dynamic> leaderboard in leaderboards) {
          LeaderBoardInstance li = LeaderBoardInstance.fromJson(leaderboard);
          lis.add(li);
        }
        setState(() {});
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
        return Column(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 40.0),
                            height: 80.0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(asr[1].imageURL),
                              radius: 40.0,
                            )),
                        Divider(
                          color: Colors.transparent,
                          height: 20.0,
                        ),
                        Text(
                          asr[1].name,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          asr[1].points.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 20.0),
                            height: 90.0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(asr[0].imageURL),
                              radius: 45.0,
                            )),
                        Divider(
                          color: Colors.transparent,
                          height: 20.0,
                        ),
                        Text(
                          asr[0].name,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          asr[0].points.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 50.0),
                            height: 70.0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(asr[2].imageURL),
                              radius: 35.0,
                            )),
                        Divider(
                          color: Colors.transparent,
                          height: 20.0,
                        ),
                        Text(
                          asr[2].name,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          asr[2].points.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  height: 20.0,
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(asr[index + 3].imageURL),
                        ),
                        title: Text(asr[index + 3].name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 30.0),
                              child: Text(
                                  asr[index + 3].batchRank.toString() + 'th'),
                            ),
                            Container(
                              child: Text(asr[index + 3].points.toString()),
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
              itemCount: asr.length - 3,
            ))
          ],
        );
      } else {
        return Text('loading...');
      }
    }
  }
}
