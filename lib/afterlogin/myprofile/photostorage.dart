import 'package:firebase_storage/firebase_storage.dart' as firebase_st;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

class PhotoStorage {
  final firebase_st.FirebaseStorage storage = firebase_st.FirebaseStorage.instance;
  Future<void> uploadPhoto(String photoPath, String uid) async {
    File file = File(photoPath);
    try {
      await storage.ref('profileP/$uid').putFile(file);
      print('zrobione');
    } on firebase_core.FirebaseException catch (e) {}
  }

  Future<String> displayPhoto(String uid) async {
    try {
      String result = await storage.ref('profileP/$uid').getDownloadURL();
      return result;
    } catch (e) {
      print('-----------------------------------------------------------------------');
      return '1';
    }
  }
}
