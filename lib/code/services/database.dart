import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/code/models/allpost.dart';
import 'package:instagram_clone/code/models/post.dart';
import 'package:instagram_clone/code/models/userdata.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference postsCollection = FirebaseFirestore.instance.collection("posts");

  Future addUserData(
    String email,
    String username,
    String fullname,
    String bio,
    String? profilepicurl,
    int numberofposts,
    int numberoffollowers,
    List<String> followers,
    int numberoffollowing,
    List<String> following,
  ) async {
    return await usersCollection
        .doc(uid)
        .set({
          'email': email,
          'username': username,
          'fullname': fullname,
          'bio': bio,
          'profilepicurl': profilepicurl,
          'numberofposts': numberofposts,
          'numberoffollowers': numberoffollowers,
          'followers': followers,
          'numberoffollowing': numberoffollowing,
          'following': following,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future updateProfile(String username, String fullname, String bio) async {
    return await usersCollection
        .doc(uid)
        .update({
          'username': username,
          'fullname': fullname,
          'bio': bio,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future updateProfilePic(String profilepicurl) async {
    // await postsCollection.snapshots().forEach((document) {
    //   try {
    //     // Only if DocumentID has only numbers
    //     if (document.) {
    //       batch.update(document.reference,
    //           {"quantity": document.data()["quantity"] - 1});
    //     }
    //   } on FormatException catch (error) {

    //     // If a document ID is unparsable. Example "lRt931gu83iukSSLwyei" is unparsable.
    //     print("The document ${error.source} could not be parsed.");
    //     return null;
    //   }
    // });
    // .doc(uid).forEach()
    // .update({
    //   'profilepicurl': profilepicurl,
    // })
    // .then((value) => print("Pic Updated"))
    // .catchError((error) => print("Failed to update user: $error"));
    return await usersCollection
        .doc(uid)
        .update({
          'profilepicurl': profilepicurl,
        })
        .then((value) => print("Pic Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future updateNum(int postNum) async {
    return await usersCollection
        .doc(uid)
        .update({
          'numberofposts': postNum + 1,
        })
        .then((value) => print("Pic Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future addPost(
    final String postURL,
    final String caption,
    final time,
    final int numberOfPosts,
    final int likes,
    final List<String> likedBy,
  ) async {
    return await postsCollection
        .doc(uid + numberOfPosts.toString())
        .set({
          'uid': uid,
          'posturl': postURL,
          'caption': caption,
          'time': time,
          'postnum': numberOfPosts,
          'likes': likes,
          'likedby': likedBy,
        })
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }

  Future updateLikesPlus(int likes, int postNum, List<dynamic> likedBy, String uidOther) async {
    likedBy.add(uid);
    return await postsCollection
        .doc(uidOther + postNum.toString())
        .update({
          'likes': ++likes,
          'likedby': likedBy,
        })
        .then((value) => print("Like Added"))
        .catchError((error) => print("${uidOther + postNum.toString()}Failed to update user: $error"));
  }

  Future updateLikesMinus(int likes, int postNum, List<dynamic> likedBy, String uidOther) async {
    likedBy.remove(uid);
    return await postsCollection
        .doc(uidOther + postNum.toString())
        .update({
          'likes': --likes,
          'likedby': likedBy,
        })
        .then((value) => print("Like removed"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future updateFollow(String uid, String uidOther, int numberOfFollowers, List<dynamic> followers,
      int numberOfFollowing, List<dynamic> following) async {
    followers.add(uid);
    following.add(uidOther);
    await usersCollection
        .doc(uidOther)
        .update({
          'followers': followers,
          'numberoffollowers': ++numberOfFollowers,
        })
        .then((value) => print("Follow updated"))
        .catchError((error) => print("Failed to update Follow: $error"));
    return await usersCollection
        .doc(uid)
        .update({
          'following': following,
          'numberoffollowing': ++numberOfFollowing,
        })
        .then((value) => print("Follow updated"))
        .catchError((error) => print("Failed to update Follow: $error"));
  }

  Future updateUnfollow(String uid, String uidOther, int numberOfFollowers, List<dynamic> followers,
      int numberOfFollowing, List<dynamic> following) async {
    followers.remove(uid);
    following.remove(uidOther);
    await usersCollection
        .doc(uidOther)
        .update({
          'followers': followers,
          'numberoffollowers': --numberOfFollowers,
        })
        .then((value) => print("Unfollow updated"))
        .catchError((error) => print("Failed to update Unfollow: $error"));
    return await usersCollection
        .doc(uid)
        .update({
          'following': following,
          'numberoffollowing': --numberOfFollowing,
        })
        .then((value) => print("Unfollow updated"))
        .catchError((error) => print("Failed to update Unfollow: $error"));
  }

  //userdata list from snapshot
  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((docs) {
      return UserData(
        uid: docs.id,
        email: docs.get('email'),
        userName: docs.get('username').toString(),
        fullName: docs.get('fullname').toString(),
        bio: docs.get('bio').toString(),
        profilePicURL: docs.get('profilepicurl').toString(),
        numberOfPosts: docs.get('numberofposts'),
        numberOfFollowers: docs.get('numberoffollowers'),
        followers: docs.get('followers'),
        numberOfFollowing: docs.get('numberoffollowing'),
        following: docs.get('following'),
      );
    }).toList();
  }

  //get users stream
  Stream<List<UserData>> get users {
    return usersCollection.snapshots().map(_userDataListFromSnapshot);
  }

  UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.id,
      email: snapshot.get('email').toString(),
      userName: snapshot.get('username').toString(),
      fullName: snapshot.get('fullname').toString(),
      bio: snapshot.get('bio').toString(),
      profilePicURL: snapshot.get('profilepicurl').toString(),
      numberOfPosts: snapshot.get('numberofposts'),
      numberOfFollowers: snapshot.get('numberoffollowers'),
      followers: snapshot.get('followers'),
      numberOfFollowing: snapshot.get('numberoffollowing'),
      following: snapshot.get('following'),
    );
  }

  Stream<UserData> get user {
    return usersCollection.doc(uid).snapshots().map(userDataFromSnapshot);
  }

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((docs) {
      return Post(
          uid: docs.get('uid'),
          postURL: docs.get('posturl'),
          caption: docs.get('caption'),
          time: docs.get('time'),
          postNum: docs.get('postnum'),
          likes: docs.get('likes'),
          likedBy: docs.get('likedby'));
    }).toList();
  }

  Stream<List<Post>> get posts {
    return postsCollection.where('uid', isEqualTo: uid).snapshots().map(_postListFromSnapshot);
  }

  List<AllPost> _allPostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<AllPost>((docs) {
      return AllPost(
          uid: docs.get('uid'),
          postURL: docs.get('posturl'),
          caption: docs.get('caption'),
          time: docs.get('time'),
          postNum: docs.get('postnum'),
          likes: docs.get('likes'),
          likedBy: docs.get('likedby'));
    }).toList();
  }

  Stream<List<AllPost>> get allposts {
    return postsCollection.orderBy('time', descending: true).snapshots().map<List<AllPost>>(_allPostListFromSnapshot);
  }
}



// class Database {
//   late FirebaseFirestore _firestore;
//   initialise() {
//     _firestore = FirebaseFirestore.instance;
//   }

//   Future<List> read() async {
//     QuerySnapshot querySnapshot;
//     List docs = [];
//     try {
//       querySnapshot =
//           await _firestore.collection('users').orderBy('timestamp').get();
//       if (querySnapshot.docs.isNotEmpty) {
//         for (var doc in querySnapshot.docs.toList()) {
//           Map a = {
//             "id": doc.id,
//             "username": doc['username'],
//           };
//           docs.add(a);
//         }
//         return docs;
//       }
//     } catch (e) {
//       print(e);
//     }
//     return read();
//   }
// }
