import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dashBoardCards.dart';
import 'package:talentify/CustomIcons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talentify/Leaderboard.dart';
import 'package:talentify/Chatbot.dart';
import 'repo.dart';
import 'profile.dart';

class dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return dashboardState();
  }
}

class dashboardState extends State<dashboard> {
  var count, taskss;
  var Exp = 0, coins = 0,pic=null;
  double screenHeight, screenWidth;
  var key, studentprof;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (key == null) getkey();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 56, 79, 1.0),
          leading:IconButton(padding: EdgeInsets.only(right: 0.0,top: 8.0,left: 15.0,bottom: 8.0),icon: Image.network('$pic'), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> profile()));
          }),
          title: Text('$Exp XP'),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/coin_icon.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Leaderboard()),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, right: 25.0),
              child: Text(
                '$coins',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.notifications, size: 30.0),
                onPressed: () {
                  print('Notification Icon pressed');
                },
              ),
            )
          ],
        ),
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (curre) {
            //print('Current Index:$curre');
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
    if (_currentIndex == 0) {
      return getTaskBody();
    } else if (_currentIndex == 1) {
      return getRoleBody();
    } else if (_currentIndex == 2) {
      return getCalendarBody();
    } else if (_currentIndex == 3) {
      return getRepoBody();
    } else if (_currentIndex == 4) {
      return getChatBody();
    }
  }

  getTaskBody() {
    if (key == null) {
      return Scaffold(
        body: Text('Loading'),
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
                    studentprof = complexobject['studentProfile'];
                    Exp = studentprof['experiencePoints'];
                    coins = studentprof['coins'];
                    pic=studentprof['profileImage'];
//                    print('$Exp');
//                    Exp=complexobject['studentProfile'];
//                    var Expp=studentProfile['experiencePoints'];
                    count = taskss.length;
                    //print('$count');
                    return PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: count, //add the length of your list here
                        itemBuilder: (BuildContext context, int index) {
                          var task = taskss[index];
                          //print(task);
                          return DashboardCards(task).getDashboardCard();
                        });
                  });
            }
          });
    }
  }

  getRoleBody() {
    return Scaffold(
      body: Text('Loading Roles'),
    );
  }

  getCalendarBody() {
    return Scaffold(
      body: Text('Loading Calendar'),
    );
  }

  getRepoBody() {
    return Scaffold(
      body: repo(),
    );
  }

  getChatBody() {
    return Scaffold(
      body: GestureDetector(
          child: Card(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Image.network(
                    'http://business.talentify.in/course_images/AI.png',
                    height: 60.0,
                    alignment: Alignment.center,
                  )),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, left: 30.0, top: 10.0),
                      child: Text(
                        'Talk with Zoya',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30.0, bottom: 15.0),
                      child: Text(
                        'I am here to resolve all of your queries',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => chatbot()),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
