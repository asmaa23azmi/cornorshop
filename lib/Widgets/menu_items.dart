import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Const/colors.dart';

class MenuItems extends StatefulWidget {
  final String text;
  final Function()? onTap;

  const MenuItems({required this.text, this.onTap, super.key});

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
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
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.normal,
              color: darkBlue,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: darkBlue,
            size: 15.w,
          ),
        ],
      ),
    );
  }
}
