import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Models/fb/user_model.dart';
import '../../Fierbase/controllers/fb_storage_controller.dart';
import '../../Models/fb/category_model.dart';
import '../../Models/fb/product_model.dart';

class ProductFbController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _collection = "products";

  ///CRUD
  Future<bool> createProduct(ProductModel product) async {
    await _firestore
        .collection(_collection)
        .doc(product.id)
        .set(product.toJson())
        .then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Stream<QuerySnapshot<ProductModel>> readProduct() async* {
    yield* _firestore
        .collection(_collection)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, options) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<ProductModel?> show(String id) async {
    var data = await _firestore
        .collection(_collection)
        .where('id', isEqualTo: id)
        .get();

    List<ProductModel> products =
        data.docs.map((e) => ProductModel.fromJson(e.data())).toList();

    if (products.isNotEmpty) return products.first;

    return null;
  }

  Stream<QuerySnapshot<ProductModel>> showUserProducts(UserModel user) async* {
    yield* _firestore
        .collection(_collection)
        .where('userModel.id', isEqualTo: user.id!)
        .orderBy('timestamp', descending: true)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, options) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<ProductModel>> showCategoryProducts(String categoryName) async* {
    yield* _firestore
        .collection(_collection)
        .where('categoryType', isEqualTo: categoryName)
        .orderBy('timestamp', descending: true)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, options) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<ProductModel>> search(String keyword) async* {
    yield* _firestore
        .collection(_collection)
        .where('name', isGreaterThanOrEqualTo: keyword)
        .withConverter<ProductModel>(
      fromFirestore: (snapshot, options) =>
          ProductModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
  

  Future<bool> updateProduct(ProductModel product) async {
    await _firestore
        .collection(_collection)
        .doc(product.id)
        .update(product.toJson())
        .then((value) => true)
        .catchError((e) => false);

    return true;
  }

  Future<void> deleteProduct(ProductModel product) async {
    await _firestore.collection(_collection).doc(product.id).delete();
    for (var item in product.img!) {
      await FbStorageController().deleteFile(item.path!);
    }
  }
}
