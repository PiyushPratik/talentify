import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'repoinstance.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class repo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return repostate();
  }
}

class repostate extends State<repo> {
  List<folder> value = [];
  List<folder> search = [];
  folder li;
  double screenHeight, screenWidth;
  int index;
  @override
  Widget build(BuildContext context) {
    if (search.length == 0) getDataFromFireBase();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(244, 246, 249, 10.0),
        body: getrepobody(),
      ),
    );
  }

  getDataFromFireBase() {
    Stream stream = Firestore.instance.collection("Repo").snapshots();
    stream.listen((data) {
      DocumentSnapshot ds = data.documents[0];
      String repodata = ds['complexobject'];
      var repodatas = json.decode(repodata);
      var datas = repodatas['data'];
      search.clear();
      value.clear();
      for (Map<String, dynamic> data in datas) {
        li = folder.fromjson(data);
       value.add(li);
       search.add(li);
      }
      setState(() {});
    });
  }

  getrepobody() {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment(Alignment.bottomCenter.x + 0.9, Alignment.bottomCenter.y - 0.5),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right:10.0 ,top:10.0 ,left: 10.0),
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none,hintText: '  Search'),
                onChanged: (text) {
                  value.clear();
                  if (text.length == 0) {
                    print('No search text');
                    value.addAll(search);
                  } else {
                    for (folder lis in search)
                      if (lis.dirName.contains(
                          text.toLowerCase()))
                        value.add(lis);
//                    print("Length: " +
//                        search.length.toString() +
//                        " count: " +
//                        value.length.toString());
                    setState(() {});
                  }
                },
              ),
            ),
            Icon(Icons.search,size: 30.0,color: Colors.black54,)
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0.0),
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) => Card(
                  margin: EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
                  elevation: 5.0,
                  child: ListTile(
                    leading: Icon(
                      Icons.folder,
                      size: 40.0,
                      color: getcolor(index),
                    ),
                    title: Text(
                      value[index].dirName,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: CircleAvatar(
                      child: Text(
                        value[index].file.file.length.toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                      backgroundColor: Color.fromRGBO(244, 246, 249, 10.0),
                      radius: 17.0,
                    ),
                    onTap: () {
                      return getOntap(index);
                    },
                  ),
                ),
          ),
        ),
      ],
    );
  }

  getOntap(index) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => window(todo: value[index])));
  }

  getcolor(int index) {
    if (index % 4 == 0) {
      return Color.fromRGBO(153, 64, 64, 80.0);
    } else if (index % 4 == 1) {
      return Colors.blue;
    } else if (index % 4 == 2) {
      return Color.fromRGBO(204, 161, 87, 80.0);
    } else {
      return Colors.lightGreen;
    }
  }
}

class window extends StatelessWidget {
  final folder todo;
  window({Key key, @required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 246, 249, 10.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 56, 79, 1.0),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(todo.dirName),
      ),
      body: getfolderbody(),
    );
  }

  getfolderbody() {
    return ListView.builder(
        padding: EdgeInsets.only(left: 3.0, right: 3.0, top: 5.0),
        itemCount: todo.file.file.length,
        itemBuilder: (BuildContext context, int index) => Container(
              height: 70.0,
              child: Card(
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.insert_drive_file,
                        size: 35.0,
                        color: Color.fromRGBO(153, 64, 64, 40.0),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: Text(
                          todo.file.file[index].createdAt,
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  title: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      todo.file.file[index].name,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () {
                    _launchURL(index);
                  },
                ),
              ),
            ));
  }

  _launchURL(index) async {
    var url = todo.file.file[index].fileUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
