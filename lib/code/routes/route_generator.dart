import 'package:flutter/material.dart';
import 'package:instagram_clone/code/screens/app/dmsection.dart';
import 'package:instagram_clone/code/screens/authorization/first_page.dart';
import 'package:instagram_clone/code/screens/authorization/sign_up.dart';
import 'package:instagram_clone/code/screens/authorization/log_in.dart';
import 'package:instagram_clone/code/screens/app/pistagram.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => FirstPage(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => SignUp(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LogIn(),
        );
      case '/pistagram':
        return MaterialPageRoute(
          builder: (_) => Pistagram(),
        );
      case '/dmsection':
        return MaterialPageRoute(
          builder: (_) => DMsection(),
        );
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
