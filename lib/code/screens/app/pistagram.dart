import 'package:flutter/material.dart';
import 'package:instagram_clone/code/screens/app/home.dart';
import 'package:instagram_clone/code/screens/app/search.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class Pistagram extends StatefulWidget {
  const Pistagram({Key? key}) : super(key: key);

  @override
  _PistagramState createState() => _PistagramState();
}

class _PistagramState extends State<Pistagram> {
  int _currentIndex = 0;

  final appBarTabs = [
    AppBarHome(),
    null,
    null,
    null,
    null,
  ];

  final tabs = [
    Home(),
    Search(),
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
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: appBarTabs[_currentIndex],
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: _themeChanger.getTheme().primaryColor,
            selectedItemColor: _themeChanger.getTheme().accentColor,
            type: BottomNavigationBarType.fixed,
            iconSize: 30.0,
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
        ),
      ),
    );
  }
}
