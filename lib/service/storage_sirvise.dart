import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance.ref();
  static const folder = "post_image";

  static Future<String> uploadImage(File _image) async {
    String image_name = "image_" + DateTime.now().toString();
    var firebaseStorage = _storage.child(folder).child(image_name);
    var uploadTask = firebaseStorage.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});

    String downloadUrl = await firebaseStorage.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}
