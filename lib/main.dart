import 'package:flutter/material.dart';
import 'package:instagram_clone/route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 50.0),
              child:
                  Image(image: AssetImage('assets/images/InstagramLogo.png'))),
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

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[50]),
          // onPressed: () => Navigator.of(context).pop(),
          onPressed: () => Navigator.of(context).pushNamed(
              '/'), //This feels better to me than the one above(commented)
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 34.0, vertical: 10.0),
                  child: Image(
                    image: AssetImage('assets/images/InstagramLogo.png'),
                  ),
                ),
                CustomTextField(placeHolderText: 'Email id'),
                CustomTextField(placeHolderText: 'Username'),
                CustomTextField(placeHolderText: 'Password'),
                CustomTextField(placeHolderText: 'Confirm Password'),
                Container(
                  margin: EdgeInsets.fromLTRB(34.0, 10.0, 34.0, 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/home',
                      );
                    },
                    child: Text('Sign up'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        height: 100,
                        indent: 34,
                        endIndent: 10,
                        color: Colors.grey[50],
                      ),
                    ),
                    Text("OR"),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        height: 100,
                        indent: 10,
                        endIndent: 34,
                        color: Colors.grey[50],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/login',
                        );
                      },
                      child: Text('Log in'),
                    )
                  ],
                ),
                Spacer(),
                Divider(
                  thickness: 0.5,
                  height: 10,
                  color: Colors.grey[50],
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Instagram from Facebook',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[50]),
          // onPressed: () => Navigator.of(context).pop(),
          onPressed: () => Navigator.of(context).pushNamed(
              '/'), //This feels better to me than the one above(commented)
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 34.0, vertical: 10.0),
                    child: Image(
                        image: AssetImage('assets/images/InstagramLogo.png'))),
                CustomTextField(placeHolderText: 'Username'),
                CustomTextField(placeHolderText: 'Password'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(34.0, 0.0, 34.0, 0.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Forgot password?'),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(34.0, 10.0, 34.0, 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/home',
                      );
                    },
                    child: Text('Log in'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        height: 100,
                        indent: 34,
                        endIndent: 10,
                        color: Colors.grey[50],
                      ),
                    ),
                    Text("OR"),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        height: 100,
                        indent: 10,
                        endIndent: 34,
                        color: Colors.grey[50],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/signup',
                        );
                      },
                      child: Text('Sign up'),
                    )
                  ],
                ),
                Spacer(),
                Divider(
                  thickness: 0.5,
                  height: 10,
                  color: Colors.grey[50],
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Instagram from Facebook',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String placeHolderText;

  const CustomTextField({
    Key? key,
    required this.placeHolderText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: placeHolderText,
          // labelStyle: TextStyle(color: Colors.grey[400]),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey, width: 0.0),
          // ),
          // isDense: true,
          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final tabs = [
    Center(
      child: Text('Bello1'),
    ),
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
        shadowColor: Colors.grey[50],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: Colors.grey[50]),
          onPressed: () {},
        ),
        title: Container(
          margin: EdgeInsets.all(80),
          child: Image(
            image: AssetImage('assets/images/InstagramLogo.png'),
            // fit: BoxFit.fitHeight,
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
            icon: Icon(Icons.tv),
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
