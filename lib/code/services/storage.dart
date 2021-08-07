import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final String uid;

  StorageService({required this.uid});

  Future<String> storeProfilePic(String path) async {
    File file = File(path);
    var snapshot = await _storage.ref().child('profilepics/' + uid).putFile(file);
    var downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> storePost(String path, int num) async {
    File file = File(path);
    var snapshot = await _storage.ref().child('posts/' + uid + '/' + num.toString()).putFile(file);
    var downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
