import 'package:flutter/material.dart';

class window extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
         Navigator.pop(context);
       }),
        title: Text('text'),
      ),
        body: Text('data'),
    );
  }
}