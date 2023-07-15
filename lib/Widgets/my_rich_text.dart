import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Const/texts.dart';

class MyRichText extends StatelessWidget {
  final String text;

  const MyRichText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 15.w),
      child: Row(
        children: [
          Text(
            text,
            style: textStyle,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            '*',
            style: TextStyle(fontSize: 14.0.sp, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
