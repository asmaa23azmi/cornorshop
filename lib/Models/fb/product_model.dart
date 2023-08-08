import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Models/fb/img_model.dart';

class ProductModel {
  String? id;
  String? name;
  String? description;
  num? price;
  late int quantity;
  String? categoryType;
  List<dynamic>? img;
  String? vendorName;
  Timestamp? timestamp;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.quantity = 1,
    required this.img,
    required this.categoryType,
    required this.vendorName,
    this.timestamp,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['productId'];
    name = json['productName'];
    description = json['productDescription'];
    price = json['productPrice'];
    quantity = json['productQuantity'];
    categoryType = json['productCategoryType'];
    img = (json['productImg'])
        .map((e) => ImgModel.fromJson(e))
        .toList();
    vendorName = json['vendorName'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['productId'] = id;
    json['productName'] = name;
    json['productDescription'] = description;
    json['productPrice'] = price;
    json['productQuantity'] = quantity;
    json['productCategoryType'] = categoryType;
    json['productImg'] = img!.map((e) => e.toJson()).toList();
    json['vendorName'] = vendorName;
    json['timestamp'] = timestamp;

    return json;
  }
}
