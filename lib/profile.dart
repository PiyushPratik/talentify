import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
              margin: EdgeInsets.only(top: 20.0, right: 35.0),
              child: Text(
                'LOG OUT',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
            )
          ],
        ),
        body: getperbody(),
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

//  getbody() {
//      return getperbody();
//  }
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
//    List<pro> li=[];
//    for(pro los in lisss){
//      //li.add(lis.title);
//    }
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Performance',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 80.0),
                child: GestureDetector(
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
                  Image.network(pic, height: screenHeight * 0.17),
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  )
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
          height: screenHeight * 0.08,
          color: Colors.white,
        ),
        Container(
          height: screenHeight * 0.35,
          color: Color.fromRGBO(234, 237, 242, 1.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Row(
                  children: <Widget>[
                    Container(
                        padding:
                            EdgeInsets.only(right: 10.0, left: 10.0, top: 75.0),
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              lisss[index].image,
                              width: 80.0,
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
