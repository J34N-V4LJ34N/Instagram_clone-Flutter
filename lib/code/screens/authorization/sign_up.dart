import 'package:flutter/material.dart';
import 'package:instagram_clone/code/services/auth.dart';
import 'package:instagram_clone/code/services/database.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String _email = '';
  String _fullname = '';
  String _username = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return loading
        ? Loading()
        : GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: _themeChanger.getTheme().accentColor),
                  // onPressed: () => Navigator.of(context).pop(),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/'), //This feels better to me than the one above(commented)
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
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
                            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              validator: (value) {
                                value!.isEmpty ? 'Enter an Email' : null;
                                !RegExp(r'\S+@\S+\.\S+').hasMatch(value) ? 'Please enter a valid email address' : null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email id',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              validator: (value) => value!.isEmpty ? 'Enter your full name' : null,
                              onChanged: (value) {
                                setState(() {
                                  _fullname = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Full Name',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              validator: (value) {
                                value!.isEmpty ? 'Enter an Username' : null;
                                // Pattern pattern =
                                //     r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                // RegExp regex = new RegExp(pattern);
                                !RegExp(r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$').hasMatch(value)
                                    ? 'Invalid username'
                                    : null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _username = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) =>
                                  value!.length < 6 ? 'Enter a password with 6 or more characters' : null,
                              onChanged: (value) {
                                setState(() {
                                  _password = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(34.0, 10.0, 34.0, 10.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth.registerWithEmailFullnameUsernameAndPassword(
                                      _email, _fullname, _username, _password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      _error = 'Please supply a valid email';
                                    });
                                  } else {
                                    await DatabaseService(uid: result!.uid)
                                        .updateUserData(_email, _username, _fullname, 'Hello, I am $_fullname');
                                    Navigator.of(context).pushReplacementNamed(
                                      '/',
                                    );
                                  }
                                  // auth.createUserWithEmailAndPassword(
                                  //     email: _email, password: _password);
                                }
                              },
                              child: Text('Sign up'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              _error,
                              style: TextStyle(
                                color: Colors.red,
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
                                'Pistagram from J34N_V4LJ34N',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
