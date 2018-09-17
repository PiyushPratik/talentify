import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'repoinstance.dart';
import 'newwindow.dart';

class repo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return repostate();
  }
}

class repostate extends State<repo> {
  List<repoinstance> value = [];
  repoinstance li;
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
                  li = repoinstance.fromjson(datas);
                  value.add(li);
                  // print(li.dirName);
                  //print(value.length);
                }
                return getrepobody();
              })),
    );
  }

  searchbar(){
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: screenWidth * 0.03,right: screenWidth * 0.03,top: screenHeight * 0.01),
          child: TextField(),
        ),
        Container(
          padding: EdgeInsets.only(left:screenWidth * 0.88,top: screenHeight * 0.02),
          child: Icon(Icons.search,size: 30.0,),
        )
      ],
    );

  }

  getrepobody() {
    return ListView.builder(
        itemCount: value.length,
        itemBuilder: (BuildContext context, int index) => FlatButton(
            padding: EdgeInsets.only(left: 4.0, right: 4.0),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> window()));
            },
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.folder,
                  size: 40.0,
                  color: getcolor(index),
                ),
                title: Text(value[index].dirName),
                trailing: CircleAvatar(
                  child: Text(
                    value[index].file.file.length.toString(),
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                  backgroundColor:Color.fromRGBO(244, 246, 249, 10.0),
                  radius: 17.0,
                ),
              ),
            )));
  }
  getcolor(int index){
    if(index % 4 == 0 ){
      return Color.fromRGBO(153, 64,64, 50.0);
    }else if(index % 4 == 1 ) {
      return Colors.blue;
    }else if(index % 4 == 2 ) {
      return Color.fromRGBO(204, 161,87, 50.0);
    }else {
      return Colors.lightGreen;
    }
  }
  }