import 'package:flutter/material.dart';
import 'package:instagram_clone/code/screens/app/home.dart';

class Pistagram extends StatefulWidget {
  const Pistagram({Key? key}) : super(key: key);

  @override
  _PistagramState createState() => _PistagramState();
}

class _PistagramState extends State<Pistagram> {
  int _currentIndex = 0;

  final tabs = [
    Home(),
    Center(
      child: Text('Bello2'),
    ),
    Center(
      child: Text('Bello3'),
    ),
    Center(
      child: Text('Bello4'),
    ),
    Center(
      child: Text('Bello5'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // shadowColor: Colors.grey[50],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: Colors.grey[50]),
          onPressed: () {},
        ),
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
          child: Center(
            child: Text(
              "Pistagram",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Billabong',
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send_outlined,
              color: Colors.grey[50],
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        backgroundColor: Colors.black,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
