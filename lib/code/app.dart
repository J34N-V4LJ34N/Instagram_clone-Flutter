import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/theuser.dart';
import 'package:instagram_clone/code/services/route_generator.dart';
import 'package:instagram_clone/code/services/auth.dart';
import 'package:instagram_clone/code/theme.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('You have an error! ${snapshot.error.toString()}');
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<ThemeChanger>(
            create: (_) => ThemeChanger(dark),
            child: MaterialAppWithTheme(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(dark),
          child: LoadingBasic(),
        );
      },
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Something went wrong lmao'),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return StreamProvider<TheUser?>.value(
      value: AuthService().user,
      initialData: TheUser(uid: 'Loading...'),
      child: MaterialApp(
        theme: theme.getTheme(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class LoadingBasic extends StatelessWidget {
  const LoadingBasic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
