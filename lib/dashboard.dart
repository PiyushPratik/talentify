import 'package:flutter/material.dart';
import 'package:talentify/login.dart';

class dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashboardState();
  }
}

class dashboardState extends State<dashboard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
              title:Text('Dashboard') ,
        ),
      body:new PageView.builder(
      scrollDirection: Axis.horizontal,
    itemCount: 5, //add the length of your list here
    itemBuilder: (BuildContext context, int index)
    {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Card(
        child:new Container(
          color: Colors.grey,
          height: 500.0,
          width: 350.0,
          padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        )
      )
    ]
    );
    }
      )
      ),
      );
  }
}