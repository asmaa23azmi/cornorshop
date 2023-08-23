import 'package:cloud_firestore/cloud_firestore.dart';
import '../../enums.dart';
import '../../Models/fb/user_model.dart';
import '../../Fierbase/controllers/fb_storage_controller.dart';

class UserFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'users';

  ///CRUD
  Future<bool> createUser(UserModel user) async {
    await _firestore
        .collection(_collection)
        .doc(user.id)
        .set(user.toJson())
        .then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Future<UserModel?> getUserInfo(String uid) async {
    var result = await _firestore
        .collection(_collection)
        .doc(uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    return result.data();
  }

  Stream<QuerySnapshot<UserModel>> readUser() async* {
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
        .orderBy('timestamp', descending: true)
        .snapshots();
  }


  Stream<QuerySnapshot<UserModel>> showVendor() async* {
    yield* _firestore
        .collection(_collection)
        .where('userType', isEqualTo: UserType.vendor.name)
        .orderBy('timestamp', descending: true)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) =>
          UserModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .snapshots();
  }

  Stream<QuerySnapshot<UserModel>> search(String keyword) async* {
    yield* _firestore
        .collection(_collection)
        .where('name', isGreaterThanOrEqualTo: keyword)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) =>
          UserModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<bool> updateUser(UserModel user) async {
    await _firestore
        .collection(_collection)
        .doc(user.id)
        .update(user.toJson())
        .then((value) => true)
        .catchError((e) => false);

    return true;
  }

  Future<void> deleteUser(UserModel user) async {
    // Delete user's data from Firestore
    await _firestore.collection(_collection).doc(user.id).delete();
    if(user.profileImg != null){
      await FbStorageController().deleteFile(user.profileImg!.path!);
    }
    // Delete the user's authentication account
    //await FbAuthController().deleteAccount(user.id ?? '');

  }
}

///collection => table
///doc(document) => row
