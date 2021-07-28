import 'package:flutter/material.dart';
import 'package:instagram_clone/code/services/auth.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String _email = '';
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
                  icon: Icon(Icons.arrow_back_ios,
                      color: _themeChanger.getTheme().accentColor),
                  // onPressed: () => Navigator.of(context).pop(),
                  onPressed: () => Navigator.of(context).pushNamed(
                      '/'), //This feels better to me than the one above(commented)
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 50.0),
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter an Email' : null,
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 34.0, vertical: 5.0),
                            child: TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter an Password' : null,
                              obscureText: true,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(34.0, 0.0, 34.0, 0.0),
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          _email, _password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      _error = 'Incorrect Credentials';
                                    });
                                    // }
                                    // auth.createUserWithEmailAndPassword(
                                    //     email: _email, password: _password);
                                  } else {
                                    Navigator.of(context).pushReplacementNamed(
                                      '/',
                                    );
                                  }
                                }
                              },
                              child: Text('Log in'),
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
