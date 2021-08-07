import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/otherprofileinfo.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/screens/app/addpost.dart';
import 'package:instagram_clone/code/screens/app/dmsection.dart';
import 'package:instagram_clone/code/screens/app/editprofile.dart';
import 'package:instagram_clone/code/screens/app/otherprofile.dart';
import 'package:instagram_clone/code/screens/authorization/sign_up.dart';
import 'package:instagram_clone/code/screens/authorization/log_in.dart';
import 'package:instagram_clone/code/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed=
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => Wrapper(),
        );
      // case '/firstpage':
      //   return MaterialPageRoute(
      //     builder: (_) => FirstPage(),
      //   );
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => SignUp(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LogIn(),
        );
      // case '/pistagram':
      //   return MaterialPageRoute(
      //     builder: (_) => Pistagram(),
      //   );
      case '/dmsection':
        return MaterialPageRoute(
          builder: (_) => DMsection(),
        );
      case '/editprofile':
        if (args is UserData) {
          return MaterialPageRoute(
            builder: (_) => EditProfile(
              userData: args,
            ),
          );
        } else
          return _errorRoute();
      case '/addpost':
        if (args is UserData) {
          return MaterialPageRoute(
            builder: (_) => AddPost(
              userData: args,
            ),
          );
        } else
          return _errorRoute();
      case '/otherprofile':
        if (args is OtherProfileInfo) {
          return MaterialPageRoute(
            builder: (_) => OtherProfile(
              uid: args.uid,
              userData: args.userData,
              otherUserData: args.otherUserData,
              otherPosts: args.otherPosts,
              isFollowing: args.isFollowing,
            ),
          );
        } else
          return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
