import 'package:flutter/material.dart';
import 'package:instagram_clone/code/screens/authorization/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return GestureDetector(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
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
                          '/pistagram',
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
                        'Pistagram from J34N_V4LJ34N',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
