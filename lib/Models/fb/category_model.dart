import 'package:cloud_firestore/cloud_firestore.dart';
import 'img_model.dart';

class CategoryModel {
  String? id;
  ImgModel? img;
  String? title;
  Timestamp? timestamp;

  CategoryModel({
    required this.id,
    required this.img,
    required this.title,
    this.timestamp,
  });

  ///from json to model
  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['categoryId'];
    img = json['categoryImg'] != null ?ImgModel.fromJson(json['categoryImg']) : null;
    title = json['categoryTitle'];
    timestamp = json['timestamp'];
  }

  ///from model to json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['categoryId'] = id;
    json['categoryImg'] =img != null ?  img!.toJson() : null;
    json['categoryTitle'] = title;
    json['timestamp'] = timestamp;
    return json;
  }
}
