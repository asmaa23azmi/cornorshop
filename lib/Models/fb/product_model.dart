import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Models/fb/category_model.dart';
import 'package:cornorshop/Models/fb/img_model.dart';
import 'package:cornorshop/Models/fb/user_model.dart';

class ProductModel {
  String? id;
  String? name;
  String? description;
  num? price;
  late int quantity;
  String? categoryType;
  List<dynamic>? img;
  UserModel? userModel;
  Timestamp? timestamp;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.quantity = 1,
    required this.img,
    this.categoryType,
    required this.userModel,
    this.timestamp,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    categoryType = json['categoryType'];
    img = (json['img']).map((e) => ImgModel.fromJson(e)).toList();
    timestamp = json['timestamp'];
    userModel = json['userModel'] != null ? UserModel.fromJson(json['userModel']) : null;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['description'] = description;
    json['price'] = price;
    json['quantity'] = quantity;
    json['categoryType'] = categoryType;
    json['img'] = img!.map((e) => e.toJson()).toList();
    json['timestamp'] = timestamp;
    json['userModel'] = userModel != null ? userModel!.toJson() : null;
    return json;
  }
}
