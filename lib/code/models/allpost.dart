class AllPost {
  final String uid;
  final String postURL;
  final String caption;
  final time;
  final int postNum;
  final int likes;
  final List<dynamic> likedBy;

  AllPost({
    required this.uid,
    required this.postURL,
    required this.caption,
    required this.time,
    required this.postNum,
    required this.likes,
    required this.likedBy,
  });
}
