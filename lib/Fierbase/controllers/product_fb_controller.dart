import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/fb/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> addToFavorites(ProductModel product) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      final CollectionReference favoritesCollection =
          _firestore.collection('users').doc(user.uid).collection('favorites');

      await favoritesCollection.add({
        'id': product.id,
        'name': product.name,
        'img': product.img?[0].link,
        'categoryType': product.categoryType,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<List<ProductModel>> getFavoriteProductsStream() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      final CollectionReference favoritesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites');

      return favoritesCollection
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return ProductModel(
            id: doc['id'],
            name: doc['name'],
            price: doc['price'],
            userModel: doc['userModel'],
            img: doc['img[0].link'],
          );
        }).toList();
      });
    } else {
      return Stream.value([]);
    }
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
