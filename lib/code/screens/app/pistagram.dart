import 'package:flutter/material.dart';
import 'package:instagram_clone/code/screens/app/home.dart';
import 'package:instagram_clone/code/screens/app/profile.dart';
import 'package:instagram_clone/code/screens/app/search.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class Pistagram extends StatefulWidget {
  // final String uid;
  const Pistagram({
    Key? key,
    // required this.uid,
  }) : super(key: key);

  @override
  _PistagramState createState() => _PistagramState();
}

class _PistagramState extends State<Pistagram> {
  int _currentIndex = 0;

  final appBarTabs = <PreferredSizeWidget?>[
    AppBarHome(),
    null,
    null,
    null,
    AppBarProfile(),
  ];

  final tabs = [
    Home(),
    Search(),
    null,
    null,
    Profile(),
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
// final user = Provider.of<UserData>(context);
//     List<UserData> loadingUsersData = [
//       UserData(
//           uid: 'Loading...', email: 'Loading...', username: 'Loading...', fullname: 'Loading...', bio: 'Loading...')
//     ];

//     UserData loadingUserData = UserData(
//         uid: 'Loading...', email: 'Loading...', username: 'Loading...', fullname: 'Loading...', bio: 'Loading...');

    // return MultiProvider(
    //   providers: [
    //     StreamProvider<TheUser?>.value(
    //   value: AuthService().user,
    //   initialData: null,
    //   ),
    //     StreamProvider<List<UserData>?>.value(
    //       initialData: loadingUsersData,
    //       value: DatabaseService(uid: widget.uid).users,
    //     ),
    //     StreamProvider<UserData>.value(
    //       initialData: loadingUserData,
    //       value: DatabaseService(uid: widget.uid).user,
    //     ),
    //   ],