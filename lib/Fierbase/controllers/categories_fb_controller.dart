import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/fb/category_model.dart';

class CategoriesFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = 'categories';

  ///CRUD
  Future<bool> create(CategoryModel category) async {
    await _firestore
        .collection(_collection)
        .doc(category.categoryId)
        .set(category.toJson())
        .then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Future<void> read() async {}

  Future<void> show() async {}

  Future<void> update() async {}

  Future<void> delete() async {}
}

///collection => table
///doc(document) => row
