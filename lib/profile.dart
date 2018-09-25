import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return profilestate();
  }
}

class profilestate extends State<profile> {
  var screenHeight, screenWidth;
  var Selected = 'Performance';
  var studentprof, key, name, rank, badges;
  var Exp = 0, coins = 0, pic = null;
  pro lis;
  List lisss = [];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (key == null) getkey();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 56, 79, 1.0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('My Profile'),
          actions: <Widget>[
            Container(
                child: FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              },
              child: Text(
                'LOG OUT',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Colors.white),
              ),
            ))
          ],
        ),
        body: getbody(),
      ),
    );
  }

  getkey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var keey = (prefs.getInt('key') ?? 0);
    setState(() {
      //print('>>>>>>>' + keey.toString());
      key = keey;
    });
  }

  getbody() {
    if (Selected == 'Performance') {
      return getperbody();
    } else {
      return Text('Loading');
    }
  }

  getperbody() {
    return new StreamBuilder(
        stream: Firestore.instance.collection('$key').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text(
              'Loading...',
              textAlign: TextAlign.center,
            );
          } else {
            //print(snapshot.hasData);
            return new PageView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot task = snapshot.data.documents[index];
                  var complexobjectString = task.data['complexobject'];
                  Map<String, dynamic> complexobject =
                      json.decode(complexobjectString);
                  studentprof = complexobject['studentProfile'];
                  Exp = studentprof['experiencePoints'];
                  coins = studentprof['coins'];
                  pic = studentprof['profileImage'];
                  name = studentprof['firstName'];
                  rank = studentprof['batchRank'];
                  badges = studentprof['badges'];
                  return getaccbody();
                });
          }
        });
  }

  getaccbody() {
    lisss.clear();
    for (Map<String, dynamic> prrofi in badges) {
      lis = pro.fromjson(prrofi);
      lisss.add(lis);
    }
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.008),
          child: Row(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    print('Performance');
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: screenWidth * 0.06),
                    child: Text(
                      'Performance',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.0),
                    ),
                  )),
              FlatButton(
                onPressed: () {
                  print('Account Settings');
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: screenWidth * 0.16),
                  child: Text(
                    'Account Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '#$rank',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Batch Rank',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(pic),
                      maxRadius: 60.0,
                    ),
                    height: screenHeight * 0.19,
                    width: screenWidth * 0.32,
                  ),

//                  Image.network(pic, height: screenHeight * 0.17),
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '$Exp',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      'XP Earned',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Divider(
          height: screenHeight * 0.1,
          color: Colors.white,
        ),
        Container(
          color: Color.fromRGBO(234, 237, 242, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: screenHeight * 0.015, top: screenHeight * 0.001),
                child: Text(
                  'Badges',
                  style: TextStyle(fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.27,
          color: Color.fromRGBO(234, 237, 242, 1.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Column(
                  children: <Widget>[
                    Container(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 8.0, top: 40.0),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              lisss[index].image,
                              width: 60.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                lisss[index].title,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
            itemCount: lisss.length,
          ),
        )
      ],
    );
  }
}

class pro {
  String image;
  int id;
  String title;
  bool is_mapped;
  pro.fromjson(Map json) {
    this.image = json['image'];
    this.id = json['id'];
    this.title = json['title'];
    this.is_mapped = json['is_mapped'];
  }
}
