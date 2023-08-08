import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/fb/user_model.dart';
import '../../Fierbase/controllers/fb_storage_controller.dart';


class UserFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'users';

  ///CRUD
  Future<bool> createCategory(UserModel user) async {
    await _firestore
        .collection(_collection)
        .doc(user.id)
        .set(user.toJson())
        .then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Stream<QuerySnapshot<UserModel>> readCategory() async* {
    yield* _firestore
        .collection(_collection)
        .withConverter<UserModel>(
      ///snapshot => json
      ///from json to model
      fromFirestore: (snapshot, options) =>
          UserModel.fromJson(snapshot.data()!),

      ///value => model
      ///from model to json
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true).snapshots();
  }

  Future<UserModel?> showCategory(UserModel user) async {
    var result = await _firestore
        .collection(_collection)
        .doc(user.id)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) => UserModel.fromJson(snapshot.data()!) ,
      toFirestore: (value, options) => value.toJson(),)
        .get();

    return result.data();
  }

  Future<bool> updateCategory(UserModel user) async {
    await _firestore
        .collection(_collection)
        .doc(user.id)
        .update(user.toJson())
        .then((value) => true)
        .catchError((e) => false);

    return true;
  }

  Future<void> deleteCategory(UserModel user) async {
    await _firestore.collection(_collection).doc(user.id).delete();
    await FbStorageController().deleteFile(user.profileImg!.path!);
  }
}

///collection => table
///doc(document) => row
