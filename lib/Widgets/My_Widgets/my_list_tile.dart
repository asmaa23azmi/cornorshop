import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';

class MyListTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color color;
  final Function()? onTap;

 const MyListTile({
    required this.text,
    required this.icon,
    this.color = darkBlue,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20.w,
          ),
          SizedBox(
            width: 25.w,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14.0.sp,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
