import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

String collection = 'foreign_video';

Future<Map?> getVideoFiles() async {
  Map files = {};
  FirebaseFirestore.instance
      .collection(collection)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      files[doc.id] = doc.data();
      print(doc.data());
    }
  });
  return files;
}


