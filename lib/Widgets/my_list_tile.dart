import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Const/colors.dart';
import '../Const/texts.dart';

class MyListTile extends StatelessWidget {
  late String text;
  late IconData? icon;
  late Function()? onTap;

  MyListTile({
    required this.text,
    required this.icon,
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
            color: darkBlue,
            size: 20.w,
          ),
          SizedBox(
            width: 25.w,
          ),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
