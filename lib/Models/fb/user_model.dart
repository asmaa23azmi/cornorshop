import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/fb/img_model.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNum;
  String? address;
  ImgModel? profileImg;
  String? sex;
  String? userType;
  String? password;
  String? description;
  String? fcm;
  Timestamp? timestamp;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNum,
      this.address,
      this.profileImg,
      this.sex,
      this.userType,
      this.password,
      this.description,
      this.fcm,
      this.timestamp});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNum = json['phoneNum'];
    address = json['address'];
    profileImg = json['profileImg'] != null
        ? ImgModel.fromJson(json['profileImg'])
        : null;
    sex = json['sex'];
    userType = json['userType'];
    password = json['password'];
    description = json['description'];
    fcm = json['fcm'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['email'] = email;
    json['phoneNum'] = phoneNum;
    json['address'] = address;
    json['profileImg'] = profileImg != null ? profileImg!.toJson() : null;
    json['sex'] = sex;
    json['userType'] = userType;
    json['password'] = password;
    json['description'] = description;
    json['fcm'] = fcm;
    json['timestamp'] = timestamp;

    return json;
  }
}
