import 'dart:io';
import '../../Models/fb/img_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FbStorageController {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ImgModel?> uploadFileToStorage(File? file,
      {required String folderName}) async {
    if (file == null) return null;
    var snapshot = await _storage
        .ref()
        .child('$folderName/${DateTime.now().toString()}')
        .putFile(file);
    String link = await snapshot.ref.getDownloadURL();
    String path =  snapshot.ref.fullPath;

    return ImgModel(link: link , path: path);
  }
  Future<void> deleteFile(String path) async{
    await _storage.ref().child(path).delete();

  }
}
