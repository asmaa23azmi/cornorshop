import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/fb/product_model.dart';

class FavoriteModel{
  String? id;
  String? buyerId;
  ProductModel? product;
  Timestamp? timestamp;

  FavoriteModel({
   required this.id,
   required this.product,
    required this.buyerId,
    this.timestamp,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    buyerId = json['buyerId'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
   json['product'] = product != null ? product!.toJson(): null;
    json['buyerId'] = buyerId;
    json['timestamp'] = timestamp;
    return json;
  }
}