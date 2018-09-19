import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'repoinstance.dart';
import 'package:url_launcher/url_launcher.dart';

class repo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return repostate();
  }
}

class repostate extends State<repo> {
  List<folder> value = [];
  folder li;
  double screenHeight, screenWidth;
  int index;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromRGBO(244, 246, 249, 10.0),
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
                  li = folder.fromjson(datas);
                  value.add(li);
                  // print(li.dirName);
                  //print(value.length);
                }
                return getrepobody();
              })),
    );
  }

//  searchbar() {
//    return Stack(
//      children: <Widget>[
//        Container(
//          color: Colors.white,
//          margin: EdgeInsets.only(
//              left: screenWidth * 0.03,
//              right: screenWidth * 0.03,
//              top: screenHeight * 0.01),
//          child: TextField(),
//        ),
//        Container(
//          padding: EdgeInsets.only(
//              left: screenWidth * 0.88, top: screenHeight * 0.02),
//          child: Icon(
//            Icons.search,
//            size: 30.0,
//          ),
//        )
//      ],
//    );
//  }

  getrepobody() {
    return ListView.builder(
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) => Card(
              margin: EdgeInsets.only(top: 11.0, right: 10.0, left: 10.0),
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
            ));
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
