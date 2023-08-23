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
    id = json['id'];
    img = json['img'] != null ?ImgModel.fromJson(json['img']) : null;
    title = json['title'];
    timestamp = json['timestamp'];
  }

  ///from model to json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['img'] =img != null ?  img!.toJson() : null;
    json['title'] = title;
    json['timestamp'] = timestamp;
    return json;
  }
}
