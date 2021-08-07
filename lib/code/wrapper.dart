import 'package:flutter/material.dart';
import 'package:instagram_clone/code/models/post.dart';
import 'package:instagram_clone/code/models/theuser.dart';
import 'package:instagram_clone/code/models/userdata.dart';
import 'package:instagram_clone/code/screens/app/pistagram.dart';
import 'package:instagram_clone/code/screens/authorization/first_page.dart';
import 'package:instagram_clone/code/services/database.dart';
import 'package:instagram_clone/code/shared/loading.dart';
import 'package:provider/provider.dart';

import 'models/allpost.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);
    if (user == null) {
      return FirstPage();
    } else if (user.uid == 'Loading...') {
      return SplashScreen();
    } else {
      List<UserData> loadingUsersData = [
        UserData(
          uid: 'Loading...',
          email: 'Loading...',
          userName: 'Loading...',
          fullName: 'Loading...',
          bio: 'Loading...',
          profilePicURL: 'Loading...',
          numberOfPosts: 0,
          numberOfFollowers: 0,
          followers: ['Jean'],
          numberOfFollowing: 0,
          following: ['Jean'],
        )
      ];

      UserData loadingUserData = UserData(
        uid: 'Loading...',
        email: 'Loading...',
        userName: 'Loading...',
        fullName: 'Loading...',
        bio: 'Loading...',
        profilePicURL: 'Loading...',
        numberOfPosts: 0,
        numberOfFollowers: 0,
        followers: ['Jean'],
        numberOfFollowing: 0,
        following: ['Jean'],
      );

      List<Post> loadingPost = [
        Post(
          uid: 'Loading...',
          postURL: 'Loading...',
          caption: 'Loading...',
          time: 'Loading...',
          postNum: 0,
          likes: 0,
          likedBy: ['Jean'],
        )
      ];

      List<AllPost> loadingAllPost = [
        AllPost(
          uid: 'Loading...',
          postURL: 'Loading...',
          caption: 'Loading...',
          time: 'Loading...',
          postNum: 0,
          likes: 0,
          likedBy: ['Jean'],
        )
      ];
      return MultiProvider(
        providers: [
          StreamProvider<List<UserData>?>.value(
            initialData: loadingUsersData,
            value: DatabaseService(uid: user.uid).users,
          ),
          StreamProvider<UserData>.value(
            initialData: loadingUserData,
            value: DatabaseService(uid: user.uid).user,
          ),
          StreamProvider<List<Post>>.value(
            initialData: loadingPost,
            value: DatabaseService(uid: user.uid).posts,
          ),
          StreamProvider<List<AllPost>>.value(
            initialData: loadingAllPost,
            value: DatabaseService(uid: user.uid).allposts,
          ),
        ],
        child: Pistagram(),
      );
    }
  }
}
