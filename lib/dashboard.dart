import 'package:flutter/material.dart';
import 'package:talentify/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return dashboardState();
  }
}

class dashboardState extends State<dashboard> {
  var count,taskss;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('Dashboard'),
          ),
          body: new StreamBuilder(
              stream: Firestore.instance.collection('27').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Text('Loading...',style: TextStyle(color: Colors.blue,),textAlign: TextAlign.center,);
                } else {
                  print(snapshot.hasData);
                  return new PageView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot task = snapshot.data.documents[index];
//                        var tasks = task['id'];
                        var complexobjectString = task.data['complexobject'];
                        Map<String, dynamic> complexobject =
                            json.decode(complexobjectString);
                        //Map<String, dynamic> taskss=json.decode(complexobject['tasks'].toString());
                        taskss = complexobject['tasks'];
                        //print('$taskss');
                        count = taskss.length;
                        print('$count');
                        return ;
                      });
                }
              })
      ),
    );
  }
}

class card extends dashboardState{
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:count, //add the length of your list here
        itemBuilder: (BuildContext context, int index) {
          var head = taskss[index];
          var title = head['title'];
          return new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Card(
                    child: new Container(
                      child: Text('$title'),
                      color: Colors.redAccent,
                      height: 420.0,
                      width: 280.0,
                    ))
              ]);
        }
    ); ;
  }
}

