import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Const/colors.dart';
//import '../Const/texts.dart';

class MyButton extends StatefulWidget {
  final String text;
  final  Function()? onTap;
  final bool loading ;
  final Color buttonColor;
  final Color textButtonColor;
  const MyButton({
    required this.text,
    this.onTap,
    this.loading = false,
    this.buttonColor= darkBlue,
    this.textButtonColor = whiteColor,
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
        height: 50.0.h,
        width: double.infinity,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadiusDirectional.circular(14.0.r),
          border: Border.all(
            color: darkBlue,
            width: 1.5.w,
          ),
        ),
        child: !widget.loading? Text(
          widget.text,
          style:  TextStyle(
            fontFamily: 'NotoKufiArabic',
            fontSize: 15.0.sp,
            fontWeight: FontWeight.normal,
            color:widget.textButtonColor,
          ),
        ): const CircularProgressIndicator(color: Colors.black,),
      ),
    );
  }
}
