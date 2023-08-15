import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

mixin ImgHelper{
  Widget  appCacheImg(String link , Widget errorImg){
    return CachedNetworkImage(
      imageUrl: link,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => errorImg,
    );
  }
}