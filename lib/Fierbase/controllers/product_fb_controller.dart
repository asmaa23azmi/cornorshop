import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Fierbase/controllers/fb_storage_controller.dart';
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

  Future<void> showProduct() async {}

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
    for(var item in product.img!){
      await FbStorageController().deleteFile(item.path!);
    }
  }
}
