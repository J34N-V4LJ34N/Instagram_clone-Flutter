class UserData {
  final String uid;
  final String email;
  final String userName;
  final String fullName;
  final String bio;
  final String? profilePicURL;
  final int numberOfPosts;
  final int numberOfFollowers;
  final List<dynamic> followers;
  final int numberOfFollowing;
  final List<dynamic> following;

  UserData({
    required this.uid,
    required this.email,
    required this.userName,
    required this.fullName,
    required this.bio,
    required this.profilePicURL,
    required this.numberOfPosts,
    required this.numberOfFollowers,
    required this.followers,
    required this.numberOfFollowing,
    required this.following,
  });
}
