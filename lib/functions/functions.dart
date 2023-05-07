import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart'  as firebase_storage;

Future<String> uploadImage(File file) async {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // Create a reference to the location where you want to upload the file
  firebase_storage.Reference ref =
      storage.ref().child('images/${DateTime.now().toString()}');

  // Upload the file to the specified path 
  firebase_storage.UploadTask task = ref.putFile(file);

  // Listen for the upload progress
  task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
    print(
        'Upload progress:------------------------------ ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
  });

  // Wait for the upload to complete
  await task;

  // Get the download URL
  String downloadURL = await ref.getDownloadURL();
  print('File uploaded successfully: $downloadURL');

  return downloadURL;
}