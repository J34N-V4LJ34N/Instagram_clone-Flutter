import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/theuser.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/screens/app/pistagram.dart';
import 'package:instagram_clone/code/screens/authorization/first_page.dart';
import 'package:instagram_clone/code/services/auth.dart';
import 'package:instagram_clone/code/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);
    if (user == null) {
      return FirstPage();
    } else {
      List<UserData> loadingUsersData = [
        UserData(
            uid: 'Loading...', email: 'Loading...', userName: 'Loading...', fullName: 'Loading...', bio: 'Loading...')
      ];

      UserData loadingUserData = UserData(
          uid: 'Loading...', email: 'Loading...', userName: 'Loading...', fullName: 'Loading...', bio: 'Loading...');
      return MultiProvider(
        providers: [
          StreamProvider<TheUser?>.value(
            value: AuthService().user,
            initialData: null,
          ),
          StreamProvider<List<UserData>?>.value(
            initialData: loadingUsersData,
            value: DatabaseService(uid: user.uid).users,
          ),
          StreamProvider<UserData>.value(
            initialData: loadingUserData,
            value: DatabaseService(uid: user.uid).user,
          ),
        ],
        child: Pistagram(),
      );
    }
  }
}
