import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/post.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/services/auth.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:provider/provider.dart';

class AppBarProfile extends StatefulWidget implements PreferredSizeWidget {
  AppBarProfile({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _AppBarProfileState createState() => _AppBarProfileState();
}

class _AppBarProfileState extends State<AppBarProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Colors.transparent,
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
        child: Text(
          Provider.of<UserData>(context).userName,
          style: TextStyle(
            color: _themeChanger.getTheme().accentColor,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_box_outlined,
            color: _themeChanger.getTheme().accentColor,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/addpost', arguments: Provider.of<UserData>(context, listen: false));
          },
        ),
        // IconButton(
        //   icon: Icon(
        //     Icons.menu,
        //     color: _themeChanger.getTheme().accentColor,
        //   ),
        //   onPressed: () {
        //     showModalBottomSheet(context: context, builder: (context) {});
        //   },
        // ),
        //TODO:  BottomSheet Menu
        PopupMenuButton(
          icon: Icon(
            Icons.menu,
            color: _themeChanger.getTheme().accentColor,
          ),
          onSelected: (result) async {
            if (result == 1) {
              _themeChanger.setTheme(dark);
            }
            if (result == 2) {
              _themeChanger.setTheme(light);
            }
            if (result == 3) {
              await _auth.signOut();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Dark"),
              value: 1,
            ),
            PopupMenuItem(
              child: Text("Light"),
              value: 2,
            ),
            PopupMenuItem(
              child: Text("Log Out"),
              value: 3,
            ),
          ],
        ),
      ],
    );
  }
}

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Profile();
//   }
// }

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: ClipOval(
                          child: (Provider.of<UserData>(context).profilePicURL == 'Loading...')
                              ? LoadingCircle()
                              : (Provider.of<UserData>(context).profilePicURL == 'null')
                                  ? Placeholder(
                                      color: _themeChanger.getTheme().accentColor,
                                      fallbackHeight: 100.0,
                                      fallbackWidth: 100.0,
                                      strokeWidth: 0.0,
                                    )
                                  : Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(Provider.of<UserData>(context).profilePicURL!),
                                      width: 100.0,
                                      height: 100.0,
                                    )),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: '${Provider.of<UserData>(context).numberOfPosts}',
                                    style: new TextStyle(
                                      color: _themeChanger.getTheme().accentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Text('Posts')
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: Provider.of<UserData>(context).numberOfFollowers.toString(),
                                    style: new TextStyle(
                                      color: _themeChanger.getTheme().accentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Text('Followers')
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            child: RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                  fontSize: 14.0,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: Provider.of<UserData>(context).numberOfFollowing.toString(),
                                      style: new TextStyle(
                                        color: _themeChanger.getTheme().accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Text('Following')
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20.0,
                  ),
                  child: RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        fontSize: 14.0,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: Provider.of<UserData>(context).fullName,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _themeChanger.getTheme().accentColor,
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20.0,
                  ),
                  child: Text(Provider.of<UserData>(context).bio),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20.0, 10.0, 3.0, 0.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/editprofile', arguments: Provider.of<UserData>(context, listen: false));
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: _themeChanger.getTheme().accentColor),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                  color: _themeChanger.getTheme().accentColor,
                                ),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(0.0),
                            backgroundColor: MaterialStateProperty.all(_themeChanger.getTheme().primaryColor),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(3.0, 10.0, 20.0, 0.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: _themeChanger.getTheme().accentColor,
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(
                                color: _themeChanger.getTheme().accentColor,
                              ),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          backgroundColor: MaterialStateProperty.all(_themeChanger.getTheme().primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            forceElevated: boxIsScrolled,
            title: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'Posts',
                    style: TextStyle(color: _themeChanger.getTheme().accentColor),
                  ),
                ),
                Tab(
                  child: Text(
                    'Tagged-(COMING SOON)',
                    style: TextStyle(color: _themeChanger.getTheme().accentColor),
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        children: <Widget>[
          PageOne(),
          PageTwo(),
        ],
        controller: _tabController,
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 1,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      itemCount: Provider.of<List<Post>>(context).length,
      itemBuilder: (context, index) => Container(
        child: Provider.of<List<Post>>(context)[index].postURL == 'Loading...'
            ? LoadingCircle()
            : Image(fit: BoxFit.cover, image: NetworkImage(Provider.of<List<Post>>(context)[index].postURL)),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // primary: false,
      padding: const EdgeInsets.all(0),
      crossAxisSpacing: 3.0,
      mainAxisSpacing: 3.0,
      crossAxisCount: 3,
      children: <Widget>[
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/300')),
        Image(image: NetworkImage('https://picsum.photos/400')),
        Image(image: NetworkImage('https://picsum.photos/200')),
      ],
    );
  }
}

// Profile

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../theme.dart';

// class AppBarProfile extends StatefulWidget implements PreferredSizeWidget {
//   AppBarProfile({Key? key})
//       : preferredSize = Size.fromHeight(kToolbarHeight),
//         super(key: key);

//   @override
//   final Size preferredSize; // default is 56.0

//   @override
//   _AppBarProfileState createState() => _AppBarProfileState();
// }

// class _AppBarProfileState extends State<AppBarProfile> {
//   @override
//   Widget build(BuildContext context) {
//     ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
//     return AppBar(
//       automaticallyImplyLeading: false,
//       shadowColor: Colors.transparent,
//       title: Container(
//         margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
//         child: Text(
//           "Kevin_Malone",
//           style: TextStyle(
//             color: _themeChanger.getTheme().accentColor,
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(
//             Icons.add_box_outlined,
//             color: _themeChanger.getTheme().accentColor,
//           ),
//           onPressed: () {
//             _themeChanger.setTheme(dark);
//           },
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.menu,
//             color: _themeChanger.getTheme().accentColor,
//           ),
//           onPressed: () {
//             _themeChanger.setTheme(light);
//           },
//         ),
//       ],
//     );
//   }
// }

// class Profile extends StatelessWidget {
//   const Profile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
//     return ListView(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: ClipOval(
//                 child: Image(
//                   image: NetworkImage(
//                       'https://openpsychometrics.org/tests/characters/test-resources/pics/TO/9.jpg'),
//                   width: 100.0,
//                   height: 100.0,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 10.0, horizontal: 20.0),
//                   child: RichText(
//                     text: new TextSpan(
//                       // Note: Styles for TextSpans must be explicitly defined.
//                       // Child text spans will inherit styles from parent
//                       style: new TextStyle(
//                         fontSize: 14.0,
//                       ),
//                       children: <TextSpan>[
//                         new TextSpan(
//                             text: '15',
//                             style: new TextStyle(
//                               color: _themeChanger.getTheme().accentColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.0,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text('Posts')
//               ],
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 10.0, horizontal: 20.0),
//                   child: RichText(
//                     text: new TextSpan(
//                       // Note: Styles for TextSpans must be explicitly defined.
//                       // Child text spans will inherit styles from parent
//                       style: new TextStyle(
//                         fontSize: 14.0,
//                       ),
//                       children: <TextSpan>[
//                         new TextSpan(
//                             text: '69',
//                             style: new TextStyle(
//                               color: _themeChanger.getTheme().accentColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.0,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text('Followers')
//               ],
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 20.0),
//                     child: RichText(
//                       text: new TextSpan(
//                         // Note: Styles for TextSpans must be explicitly defined.
//                         // Child text spans will inherit styles from parent
//                         style: new TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         children: <TextSpan>[
//                           new TextSpan(
//                               text: '420',
//                               style: new TextStyle(
//                                 color: _themeChanger.getTheme().accentColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20.0,
//                               )),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Text('Following')
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 0,
//             horizontal: 20.0,
//           ),
//           child: RichText(
//             text: new TextSpan(
//               // Note: Styles for TextSpans must be explicitly defined.
//               // Child text spans will inherit styles from parent
//               style: new TextStyle(
//                 fontSize: 14.0,
//               ),
//               children: <TextSpan>[
//                 new TextSpan(
//                     text: 'Kevin Malone',
//                     style: new TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 0,
//             horizontal: 20.0,
//           ),
//           child: Text(
//               "My name is Kevin \nthat is my name \nthey call me Kevin \nCuz that's my name"),
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(20.0, 10.0, 3.0, 40.0),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: Text(
//                     'Edit Profile',
//                     style:
//                         TextStyle(color: _themeChanger.getTheme().accentColor),
//                   ),
//                   style: ButtonStyle(
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.zero,
//                         side: BorderSide(
//                           color: _themeChanger.getTheme().accentColor,
//                         ),
//                       ),
//                     ),
//                     elevation: MaterialStateProperty.all<double>(0.0),
//                     backgroundColor: MaterialStateProperty.all(
//                         _themeChanger.getTheme().primaryColor),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(3.0, 10.0, 20.0, 40.0),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Icon(
//                   Icons.arrow_drop_down,
//                   color: _themeChanger.getTheme().accentColor,
//                 ),
//                 style: ButtonStyle(
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.zero,
//                       side: BorderSide(
//                         color: _themeChanger.getTheme().accentColor,
//                       ),
//                     ),
//                   ),
//                   elevation: MaterialStateProperty.all<double>(0.0),
//                   backgroundColor: MaterialStateProperty.all(
//                       _themeChanger.getTheme().primaryColor),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         DefaultTabController(
//           length: 4, // length of tabs
//           initialIndex: 0,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Container(
//                 child: TabBar(
//                   labelColor: Colors.green,
//                   unselectedLabelColor: Colors.black,
//                   tabs: [
//                     Tab(text: 'Tab 1'),
//                     Tab(text: 'Tab 2'),
//                     Tab(text: 'Tab 3'),
//                     Tab(text: 'Tab 4'),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 400, //height of TabBarView
//                 decoration: BoxDecoration(
//                     border: Border(
//                         top: BorderSide(color: Colors.grey, width: 0.5))),
//                 child: TabBarView(
//                   children: <Widget>[
//                     Container(
//                       child: Center(
//                         child: Text('Display Tab 1',
//                             style: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                     Container(
//                       child: Center(
//                         child: Text('Display Tab 2',
//                             style: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                     Container(
//                       child: Center(
//                         child: Text('Display Tab 3',
//                             style: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                     Container(
//                       child: Center(
//                         child: Text('Display Tab 4',
//                             style: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// Profile 2

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'dart:math' as math;

// import '../../theme.dart';

// class Profile2 extends StatelessWidget {
//   const Profile2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CollapsingList();
//   }
// }

// class CollapsingList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
//     return DefaultTabController(
//       length: 2,
//       child: CustomScrollView(
//         slivers: <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       child: ClipOval(
//                         child: Image(
//                           image: NetworkImage(
//                               'https://openpsychometrics.org/tests/characters/test-resources/pics/TO/9.jpg'),
//                           width: 100.0,
//                           height: 100.0,
//                         ),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 20.0),
//                           child: RichText(
//                             text: new TextSpan(
//                               // Note: Styles for TextSpans must be explicitly defined.
//                               // Child text spans will inherit styles from parent
//                               style: new TextStyle(
//                                 fontSize: 14.0,
//                               ),
//                               children: <TextSpan>[
//                                 new TextSpan(
//                                     text: '15',
//                                     style: new TextStyle(
//                                       color:
//                                           _themeChanger.getTheme().accentColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20.0,
//                                     )),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Text('Posts')
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 20.0),
//                           child: RichText(
//                             text: new TextSpan(
//                               // Note: Styles for TextSpans must be explicitly defined.
//                               // Child text spans will inherit styles from parent
//                               style: new TextStyle(
//                                 fontSize: 14.0,
//                               ),
//                               children: <TextSpan>[
//                                 new TextSpan(
//                                     text: '69',
//                                     style: new TextStyle(
//                                       color:
//                                           _themeChanger.getTheme().accentColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20.0,
//                                     )),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Text('Followers')
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 20.0),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 20.0),
//                             child: RichText(
//                               text: new TextSpan(
//                                 // Note: Styles for TextSpans must be explicitly defined.
//                                 // Child text spans will inherit styles from parent
//                                 style: new TextStyle(
//                                   fontSize: 14.0,
//                                 ),
//                                 children: <TextSpan>[
//                                   new TextSpan(
//                                       text: '420',
//                                       style: new TextStyle(
//                                         color: _themeChanger
//                                             .getTheme()
//                                             .accentColor,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20.0,
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Text('Following')
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 20.0,
//                   ),
//                   child: RichText(
//                     text: new TextSpan(
//                       // Note: Styles for TextSpans must be explicitly defined.
//                       // Child text spans will inherit styles from parent
//                       style: new TextStyle(
//                         fontSize: 14.0,
//                       ),
//                       children: <TextSpan>[
//                         new TextSpan(
//                             text: 'Kevin Malone',
//                             style: new TextStyle(fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 0,
//                     horizontal: 20.0,
//                   ),
//                   child: Text(
//                       "My name is Kevin \nthat is my name \nthey call me Kevin \nCuz that's my name"),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         margin: EdgeInsets.fromLTRB(20.0, 10.0, 3.0, 0.0),
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           child: Text(
//                             'Edit Profile',
//                             style: TextStyle(
//                                 color: _themeChanger.getTheme().accentColor),
//                           ),
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.zero,
//                                 side: BorderSide(
//                                   color: _themeChanger.getTheme().accentColor,
//                                 ),
//                               ),
//                             ),
//                             elevation: MaterialStateProperty.all<double>(0.0),
//                             backgroundColor: MaterialStateProperty.all(
//                                 _themeChanger.getTheme().primaryColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(3.0, 10.0, 20.0, 0.0),
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         child: Icon(
//                           Icons.arrow_drop_down,
//                           color: _themeChanger.getTheme().accentColor,
//                         ),
//                         style: ButtonStyle(
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.zero,
//                               side: BorderSide(
//                                 color: _themeChanger.getTheme().accentColor,
//                               ),
//                             ),
//                           ),
//                           elevation: MaterialStateProperty.all<double>(0.0),
//                           backgroundColor: MaterialStateProperty.all(
//                               _themeChanger.getTheme().primaryColor),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SliverAppBar(
//             pinned: true,
//             automaticallyImplyLeading: false,
//             title: TabBar(
//               tabs: [
//                 Tab(text: 'Icons.Posts'),
//                 Tab(text: 'Icons.tagged'),
//               ],
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: TabBarView(
//               children: [
//                 Icon(Icons.directions_car),
//                 Icon(Icons.directions_transit),
//               ],
//             ),
//           ),
//           SliverGrid.count(
//             crossAxisCount: 3,
//             children: [
//               Container(color: Colors.red, height: 150.0),
//               Container(color: Colors.purple, height: 150.0),
//               Container(color: Colors.green, height: 150.0),
//               Container(color: Colors.orange, height: 150.0),
//               Container(color: Colors.yellow, height: 150.0),
//               Container(color: Colors.pink, height: 150.0),
//               Container(color: Colors.cyan, height: 150.0),
//               Container(color: Colors.indigo, height: 150.0),
//               Container(color: Colors.blue, height: 150.0),
//             ],
//           ),
//           // SliverList(
//           //   delegate: SliverChildListDelegate(
//           //     [
//           //       Container(
//           //         height: MediaQuery.of(context).size.height - 205,
//           //         decoration: BoxDecoration(
//           //             border: Border(
//           //                 top: BorderSide(color: Colors.grey, width: 0.5))),
//           //         child: TabBarView(
//           //           children: <Widget>[
//           //             GridView.count(
//           //               primary: false,
//           //               padding: const EdgeInsets.all(20),
//           //               crossAxisSpacing: 10,
//           //               mainAxisSpacing: 10,
//           //               crossAxisCount: 2,
//           //               children: <Widget>[
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child:
//           //                       const Text("He'd have you all unravel at the"),
//           //                   color: Colors.teal[100],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Heed not the rabble'),
//           //                   color: Colors.teal[200],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Sound of screams but the'),
//           //                   color: Colors.teal[300],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Who scream'),
//           //                   color: Colors.teal[400],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Revolution is coming...'),
//           //                   color: Colors.teal[500],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Revolution, they...'),
//           //                   color: Colors.teal[600],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Revolution, they...'),
//           //                   color: Colors.teal[600],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Revolution, they...'),
//           //                   color: Colors.teal[600],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Revolution, they...'),
//           //                   color: Colors.teal[600],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Revolution, they...'),
//           //                   color: Colors.teal[600],
//           //                 ),
//           //                 Container(
//           //                   padding: const EdgeInsets.all(8),
//           //                   child: const Text('Revolution, they...'),
//           //                   color: Colors.teal[600],
//           //                 ),
//           //               ],
//           //             ),
//           //             Container(
//           //               child: Center(
//           //                 child: Text('Display Tab 2',
//           //                     style: TextStyle(
//           //                         fontSize: 22, fontWeight: FontWeight.bold)),
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
