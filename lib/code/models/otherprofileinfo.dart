import 'package:instagram_clone/code/models/allpost.dart';
import 'package:instagram_clone/code/models/userdata.dart';

class OtherProfileInfo {
  final String uid;
  final UserData userData;
  final UserData otherUserData;
  final List<AllPost> otherPosts;
  final bool isFollowing;

  OtherProfileInfo({
    required this.uid,
    required this.userData,
    required this.otherUserData,
    required this.otherPosts,
    required this.isFollowing,
  });
}
