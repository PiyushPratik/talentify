import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'repoinstance.dart';

class repo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return repostate();
  }
}

class repostate extends State<repo> {
  List<repoinstance> value = [];
  repoinstance li;
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
                var data = repodatas['data'];
                value.clear();
                for (Map<String, dynamic> datas in data) {
                  li = repoinstance.fromjson(datas);
                  value.add(li);
                  print(li.dirName);
                  print(value.length);
                }
                return getrepobody();
              })),
    );
  }

  getrepobody() {
    return ListView.builder(
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                leading: Icon(Icons.folder),
                title: Text(value[index].dirName),
                trailing: Text(value[index].file.length),
              ),
            ));
  }
}
