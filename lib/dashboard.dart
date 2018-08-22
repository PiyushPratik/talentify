import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dashBoardCards.dart';
import 'package:talentify/CustomIcons.dart';
import 'package:shared_preferences/shared_preferences.dart';


class dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return dashboardState();
  }
}

class dashboardState extends State<dashboard> {
  var count, taskss;
  var Exp=0;
  var key;
  // var id1=LoginState.id;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (key == null) getkey();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 56, 79, 1.0),
          title: Text('Xp $Exp'),
          actions: <Widget>[
            IconButton(icon: Image.asset('assets/images/coin_icon.png')),
            IconButton(
              icon: Icon(Icons.notifications, size: 30.0),
              onPressed: () {
                print('Notification Icon pressed');
              },
            )
          ],
        ),
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (curre) {
            print('Current Index:$curre');
            setState(() {
              _currentIndex = curre;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.tasks_icon,
                color: _currentIndex == 0 ? Colors.red : Colors.grey,
              ),
              title: new Text('Tasks',
                  style: TextStyle(
                    color: _currentIndex == 0 ? Colors.red : Colors.grey,
                  )),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.roles_icon,
                color: _currentIndex == 1 ? Colors.red : Colors.grey,
              ),
              title: new Text('Roles',
                  style: TextStyle(
                    color: _currentIndex == 1 ? Colors.red : Colors.grey,
                  )),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.calendar_icon,
                  color: _currentIndex == 2 ? Colors.red : Colors.grey,
                ),
                title: Text('Calendar',
                    style: TextStyle(
                      color: _currentIndex == 2 ? Colors.red : Colors.grey,
                    ))),
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.repository,
                  color: _currentIndex == 3 ? Colors.red : Colors.grey,
                ),
                title: Text('Respository',
                    style: TextStyle(
                      color: _currentIndex == 3 ? Colors.red : Colors.grey,
                    ))),
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.chat_icon,
                  color: _currentIndex == 4 ? Colors.red : Colors.grey,
                ),
                title: Text('Chat',
                    style: TextStyle(
                      color: _currentIndex == 4 ? Colors.red : Colors.grey,
                    ))),
          ],
        ),
      ),
    );
  }

  getkey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var keey = (prefs.getInt('key') ?? 0);
    setState(() {
      //print('>>>>>>>' + keey.toString());
      key = keey;
    });
  }

  getBody() {
    if (key == null) {
      return MaterialApp(
        home: Text('Loading'),
      );
    } else {
      return new StreamBuilder(
          stream: Firestore.instance.collection('$key').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const Text(
                'Loading...',
                textAlign: TextAlign.center,
              );
            } else {
              //print(snapshot.hasData);
              return new PageView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot task = snapshot.data.documents[index];
                    var complexobjectString = task.data['complexobject'];
                    Map<String, dynamic> complexobject =
                        json.decode(complexobjectString);
                    taskss = complexobject['tasks'];
                    count = taskss.length;
                    print('$count');
                    return PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: count, //add the length of your list here
                        itemBuilder: (BuildContext context, int index) {
                          var task = taskss[index];
                          return DashboardCards(task).getDashboardCard();
                        });
                  });
            }
          });
    }
  }

}
