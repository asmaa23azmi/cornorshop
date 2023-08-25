import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/fb/cart_model.dart';

class CartFbController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = "carts";

  Future<bool> addToCart(CartModel cartModel) async {
    await _firestore
        .collection(_collection)
        .doc(cartModel.id)
        .set(cartModel.toJson()).then((value) => true)
        .catchError((exception) => false);
    return true;
  }

  Stream<QuerySnapshot<CartModel>> readFromCart(String buyerId) async* {
    yield* _firestore
        .collection(_collection)
    .where('buyerId', isEqualTo:  buyerId)
        .withConverter<CartModel>(
      fromFirestore: (snapshot, options) =>
          CartModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> deleteFromCart(CartModel cart) async{
    await _firestore.collection(_collection).doc(cart.id).delete();
  }
}