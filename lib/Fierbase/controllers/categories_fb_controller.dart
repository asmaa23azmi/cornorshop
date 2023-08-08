import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Fierbase/controllers/fb_storage_controller.dart';
import '../../Models/fb/category_model.dart';

class CategoriesFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'categories';

  ///CRUD
  Future<bool> createCategory(CategoryModel category) async {
    await _firestore
        .collection(_collection)
        .doc(category.id)
        .set(category.toJson())
        .then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Stream<QuerySnapshot<CategoryModel>> readCategory() async* {
    yield* _firestore
        .collection(_collection)
        .withConverter<CategoryModel>(
          ///snapshot => json
          ///from json to model
          fromFirestore: (snapshot, options) =>
              CategoryModel.fromJson(snapshot.data()!),

          ///value => model
          ///from model to json
          toFirestore: (value, options) => value.toJson(),
        )
        .orderBy('timestamp', descending: true).snapshots();
  }

  Future<CategoryModel?> showCategory(CategoryModel category) async {
   var result = await _firestore
        .collection(_collection)
        .doc(category.id)
        .withConverter<CategoryModel>(
            fromFirestore: (snapshot, options) => CategoryModel.fromJson(snapshot.data()!) ,
        toFirestore: (value, options) => value.toJson(),)
        .get();

   return result.data();
  }

  Future<bool> updateCategory(CategoryModel category) async {
    await _firestore
        .collection(_collection)
        .doc(category.id)
        .update(category.toJson())
        .then((value) => true)
        .catchError((e) => false);

    return true;
  }

  Future<void> deleteCategory(CategoryModel category) async {
    await _firestore.collection(_collection).doc(category.id).delete();
    await FbStorageController().deleteFile(category.img!.path!);
  }
}

///collection => table
///doc(document) => row
