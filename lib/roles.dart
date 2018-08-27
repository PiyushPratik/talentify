import 'package:flutter/material.dart';

class roles extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return rolesState();
  }
}

class rolesState extends State<roles>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body:Card(
           child:Text('Hello'),
        ) ,
      ),
    );
  }
}