import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Fierbase/controllers/fb_storage_controller.dart';
import '../../Models/fb/category_model.dart';

class CategoriesFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'categories';

  ///CRUD
  Future<bool> createCategory(CategoryModel category) async {
    try {
      final existingCategories = await FirebaseFirestore.instance
          .collection('categories')
          .where('title', isEqualTo: category.title)
          .get();
      if (existingCategories.docs.isNotEmpty) {
        print('Category already exists');
      } else {
        await _firestore
            .collection(_collection)
            .doc(category.id)
            .set(category.toJson())
            .then((value) => true)
            .catchError((exception) => false);
        return true;
      }
    } catch (e) {}
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
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<CategoryModel>> show(String id) async* {
    yield* _firestore
        .collection(_collection)
        .where('id', isEqualTo: id)
        .withConverter<CategoryModel>(
          fromFirestore: (snapshot, options) =>
              CategoryModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<CategoryModel>> search(String keyword) async* {
    yield* _firestore
        .collection(_collection)
        .where('name', isGreaterThanOrEqualTo: keyword)
        .withConverter<CategoryModel>(
      fromFirestore: (snapshot, options) =>
          CategoryModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true)
        .snapshots();
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
