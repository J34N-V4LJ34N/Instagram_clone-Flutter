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
