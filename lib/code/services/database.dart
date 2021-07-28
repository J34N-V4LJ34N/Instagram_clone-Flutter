import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/code/models/userdata.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String email, String username, String fullname, String bio) async {
    return await usersCollection.doc(uid).set({
      'email': email,
      'username': username,
      'fullname': fullname,
      'bio': bio,
    });
  }

  //userdata list from snapshot
  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((docs) {
      return UserData(
        uid: uid,
        email: docs.get('email'),
        userName: docs.get('username').toString(),
        fullName: docs.get('fullname').toString(),
        bio: docs.get('bio').toString(),
      );
    }).toList();
  }

  //get users stream
  Stream<List<UserData>> get users {
    return usersCollection.snapshots().map(_userDataListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.get('email'),
      userName: snapshot.get('username').toString(),
      fullName: snapshot.get('fullname').toString(),
      bio: snapshot.get('bio').toString(),
    );
  }

  Stream<UserData> get user {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
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
