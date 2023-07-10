import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin SnackBarHelper {
  void showMySnackBar(
    BuildContext context, {
    required String text,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsetsDirectional.symmetric(horizontal: 6.w, vertical: 6.h),
        content: Text(
          text,
          style: const TextStyle(fontFamily: 'NotoKufiArabic'),
        ),
      ),
    );
  }
}
