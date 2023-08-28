import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/fb/product_model.dart';
import '../../Models/fb/user_model.dart';

class CommentModel{
String? id;
String? text;
UserModel? user;
ProductModel? product;
Timestamp? timestamp;

CommentModel({
  required this.id,
  required this.text,
  required this.user,
  required this.product,
  required this.timestamp});

CommentModel.fromJson(Map<String, dynamic> json){
  id = json['id'];
  text = json['text'];
  product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  timestamp = json['timestamp'];
}

Map<String, dynamic> toJson() {
  Map<String, dynamic> json = {};
  json['id'] = id;
  json['text'] = text;
  json['product'] = product != null ? product!.toJson(): null;
  json['user'] = user != null ? user!.toJson(): null;
  json['timestamp'] = timestamp;
  return json;
}

}