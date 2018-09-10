import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class repo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return repostate();
  }
}

class repostate extends State<repo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: new StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("Repo").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                }
                var length = snapshot.data.documents.length;
                DocumentSnapshot ds = snapshot.data.documents[length - 1];
                String repodata = ds['complexobject'];
                var repodatas = json.decode(repodata);
               // print(repodatas);
                return Text('');
              })),
    );
  }
}
