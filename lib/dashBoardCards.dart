import 'package:flutter/material.dart';
import 'package:talentify/CustomIcons.dart';

class DashboardCards {
  var task;

  DashboardCards(t) {
    this.task = t;
  }

  Widget getDashboardCard() {
    var type = task['itemType'];
    var status=task['status'];
    print('$type');
    if (type == 'SALES_CALL_TASK' && status=='INCOMPLETE') {
     // print('hi');
      return getcall();
      // return sales call card
    } else if (type == 'SALES_PRESENTATION_TASK' && status=='INCOMPLETE') {
      //print('hello');
      return getpresentation();
      //return some other template
    } else if (type == 'SALES_WEBINAR_TASK' && status=='INCOMPLETE') {
      //print('World');
      return getwebinar();
      //return some other template
    }
  }

  getcall() {
    var title = task['title'];
    var header=task['header'];
    print('$title');
    return Stack(
      alignment:
          Alignment(Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.22),
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 70.0),
            height: 530.0,
            width: 400.0,
            child: Card(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft, child: Text('$header',style: TextStyle(color: Colors.grey,fontSize: 15.0),)),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('$title',
                        style: TextStyle(color: Colors.black, fontSize: 30.0)),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/sales_call_icon.png',
                      height: 150.0,
                      width: 200.0,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Next, diagram each row. The first row, called the Title section, has 3 children: a column of text, a star icon, and a number. Its first child, the column, contains 2 lines of text. That first column takes a lot of space, so it must be wrapped in an Expanded widget.',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(CustomIcons.calendar_icon),
                          Text('16/08/2018'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.timer),
                          Text('06.20 PM'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Color.fromRGBO(235, 56, 79, 1.0),
          textColor: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.phone),
              Text(
                '  CALL',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          onPressed: () {
            print('Button pressed');
          },
        )
      ],
    );
  }

  getpresentation() {
    var header=task['header'];
    var title = task['title'];
    print('$title');
    return Stack(
      alignment:
          Alignment(Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.22),
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 70.0),
            height: 530.0,
            width: 400.0,
            child: Card(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '$header',style: TextStyle(color: Colors.grey,fontSize: 15.0),
                      )),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$title',
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child:
                        Image.asset('assets/images/presentaion_task_icon.png'),
                    height: 150.0,
                    width: 200.0,
                  ),
                  Container(
                    child: Text(
                      'Next, diagram each row. The first row, called the Title section, has 3 children: a column of text, a star icon, and a number. Its first child, the column, contains 2 lines of text. That first column takes a lot of space, so it must be wrapped in an Expanded widget.',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(CustomIcons.calendar_icon),
                          Text('16/08/2018'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.timer),
                          Text('06.20 PM'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Color.fromRGBO(235, 56, 79, 1.0),
          textColor: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.desktop_windows),
              Text('  Presentation', style: TextStyle(fontSize: 20.0)),
            ],
          ),
          onPressed: () {
            print('Button pressed');
          },
        )
      ],
    );
  }

  getwebinar() {
    var header=task['header'];
    var title = task['title'];
    print('$title');
    return Stack(
      alignment:
          Alignment(Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.22),
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 70.0),
            height: 530.0,
            width: 400.0,
            child: Card(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft, child: Text('$header',style: TextStyle(color: Colors.grey,fontSize: 15.0))),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$title',
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/images/video_conference.png'),
                    height: 150.0,
                    width: 200.0,
                  ),
                  Container(
                    child: Text(
                      'Next, diagram each row. The first row, called the Title section, has 3 children: a column of text, a star icon, and a number. Its first child, the column, contains 2 lines of text. That first column takes a lot of space, so it must be wrapped in an Expanded widget.',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.timer),
                          Text('N/A'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.group),
                          Text('N/A'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Color.fromRGBO(235, 56, 79, 1.0),
          textColor: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.play_circle_outline),
              Text('  START MEETING', style: TextStyle(fontSize: 20.0)),
            ],
          ),
          onPressed: () {
            print('Button pressed');
          },
        )
      ],
    );
  }
}
