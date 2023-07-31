import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


mixin ImgPickerHelper<T extends StatefulWidget> on State<T> {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    XFile? data = await _picker.pickImage(source: ImageSource.gallery);
    if (data == null) return null;
    return File(data.path);
  }

  Future<List<File>> pickMultiImagesFromGallery() async {
    List<XFile> data = await _picker.pickMultiImage();

    return data.map((xFile) => File(xFile.path)).toList();
  }
}
