import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/colors.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool loading;
  final Color buttonColor;
  final Color borderBouttonColor;
  final Color textButtonColor;
  final double myHeight;
  final double myWidth;
  final double myFontSize;

  const MyButton(
      {required this.text,
      this.onTap,
      this.loading = false,
      this.buttonColor = darkBlue,
      this.borderBouttonColor = Colors.transparent,
      this.textButtonColor = whiteColor,
      this.myHeight = 50,
      this.myWidth = double.infinity,
      this.myFontSize = 15,
      super.key});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: Container(
        height: widget.myHeight.h,
        width: widget.myWidth.w,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadiusDirectional.circular(14.0.r),
          border: Border.all(
            color: widget.borderBouttonColor,
            width: 1.w,
          ),
        ),
        child: !widget.loading
            ? Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.myFontSize.sp,
                  fontWeight: FontWeight.normal,
                  color: widget.textButtonColor,
                ),
              )
            : SizedBox(
                height: 20.h,
                width: 20.h,
                child:  CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: .8.w,
                ),
              ),
      ),
    );
  }
}
