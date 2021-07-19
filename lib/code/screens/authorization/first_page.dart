import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
            child: Center(
              child: Text(
                "Pistagram",
                style: TextStyle(
                  fontSize: 70,
                  fontFamily: 'Billabong',
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/login',
                );
              },
              child: Text('Log in'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 0.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/signup',
                );
              },
              child: Text('Sign up'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
