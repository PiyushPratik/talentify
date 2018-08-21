import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dashBoardCards.dart';

class dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return dashboardState();
  }
}

class dashboardState extends State<dashboard> {
  var count, taskss;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text('Dashboard'),
          ),
          body: new StreamBuilder(
              stream: Firestore.instance.collection('198108').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  );
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
                        return PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: count, //add the length of your list here
                            itemBuilder: (BuildContext context, int index) {
                              var task = taskss[index];
                              return DashboardCards(task).getDashboardCard();
                            });
                      });
                }
              })),
    );
  }
}

class card extends dashboardState {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
