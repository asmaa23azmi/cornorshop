import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


mixin ImgPickerHelper<T extends StatefulWidget> on State<T> {
  File? profileImg;
  List<XFile>? multiImg=[];

  Future<void> pickImgFromGallery({bool multiImgs = false}) async {
    ImagePicker imgPicker = ImagePicker();
    if (multiImgs) {
        List<XFile>? pickedImg = await imgPicker.pickMultiImage();
        //you can use ImageCourse.camera for Camera capture
        if(pickedImg != null){
          multiImg!.addAll(pickedImg);
          setState(() {
            //productImg = File(multiImg[index].path);

          });
        }

    } else {
      XFile? img = await imgPicker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        setState(() {
          profileImg = File(img.path);
        });
      }
    }
  }
}
