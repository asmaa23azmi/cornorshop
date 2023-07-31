import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';

class MyListItem extends StatefulWidget {
  final String text;
  late IconData icon;
  final Function()? onTap;
  final double size;

  MyListItem(
      {required this.text,
      required this.icon,
      this.onTap,
      this.size = 15,
      super.key});

  @override
  State<MyListItem> createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: textStyle,
          ),
          Icon(
            widget.icon,
            color: darkBlue,
            size: widget.size.w,
          ),
        ],
      ),
    );
  }
}
