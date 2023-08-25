import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Models/fb/favorit_model.dart';

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

  Future<void> removeFromFavorite(FavoriteModel favorite) async{
    await _firestore.collection(_collection).doc(favorite.id).delete();
  }
}