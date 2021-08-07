import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger2 = Provider.of<ThemeChanger>(context);
    return Container(
      color: _themeChanger2.getTheme().primaryColor,
      child: Center(
        child: SpinKitCubeGrid(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger2 = Provider.of<ThemeChanger>(context);
    return Container(
      color: _themeChanger2.getTheme().primaryColor,
      child: Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
          child: Center(
            child: Text(
              "Pistagram",
              style: TextStyle(
                color: theme.getTheme().accentColor,
                fontSize: 40,
                fontFamily: 'Billabong',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
