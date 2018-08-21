import 'package:flutter/material.dart';

class DashboardCards {
  var task;
  DashboardCards(t) {
    this.task = t;
  }
  Widget getDashboardCard() {
    var type = task['type'];
    if(type=='SALES_TASK_CALL'){
      // return sales call card
    } else if(type=='SOME_OTHER_TYPE'){
      //return some other template
    }

    var title = task['title'];
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
}
