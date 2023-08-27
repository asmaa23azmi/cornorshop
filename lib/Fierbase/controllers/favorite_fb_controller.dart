import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Models/fb/favorit_model.dart';
import 'package:cornorshop/Models/fb/product_model.dart';

import '../../Models/fb/cart_model.dart';

class FavoriteFbController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = "favoritesProducts";

  Future<bool> addToFavorite(FavoriteModel favorite) async {
    await _firestore
        .collection(_collection)
        .doc(favorite.id)
        .set(favorite.toJson()).then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Stream<QuerySnapshot<FavoriteModel>> readFavoriteProduct(String buyerId) async* {
    yield* _firestore
        .collection(_collection)
    .where('buyerId', isEqualTo:  buyerId)
        .withConverter<FavoriteModel>(
      fromFirestore: (snapshot, options) =>
          FavoriteModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<FavoriteModel>> showFavoriteProduct(String productId) async* {
    yield* _firestore
        .collection(_collection)
        .where('product.id', isEqualTo:  productId)
        .withConverter<FavoriteModel>(
      fromFirestore: (snapshot, options) =>
          FavoriteModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<bool> show(String productId, String buyerId) async {
    var data = await _firestore
        .collection(_collection)
        .where('product.id', isEqualTo:  productId)
        .where('buyerId', isEqualTo:  buyerId)
        .get();

    List<FavoriteModel> products =
    data.docs.map((e) => FavoriteModel.fromJson(e.data())).toList();

    if (products.isNotEmpty) return true;

    return false;
  }

  Future<void> removeFromFavorite(FavoriteModel favorite) async{
    await _firestore.collection(_collection).doc(favorite.id).delete();
  }

  Future<void> removeFromFav(ProductModel product) async{
   try{
     await _firestore.collection(_collection).doc(product.id).delete();
     print('Product removed from favorites successfully.');
   }catch(error){
     print('Error removing product from favorites: $error');
   }
  }

}