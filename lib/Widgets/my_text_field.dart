import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Const/colors.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconButton? prefixIcon;
  final Color textFieldColor;
  final Color textFieldBorderColor;
  final bool password;
  final TextInputType inputType;
  final Color hintSyleColor;
  final Function(String value)? onChange;
  final int maxLines;
  final double textFieldHeigth;
  final double textFieldWidth;
  final bool outoFouce;

  const MyTextField(
      {required this.controller,
      required this.hintText,
      this.password = false,
      this.prefixIcon,
      this.textFieldColor = whiteColor,
      this.textFieldBorderColor = Colors.transparent,
      this.inputType = TextInputType.text,
      this.onChange,
      this.hintSyleColor = grayColor,
      this.maxLines = 1,
      this.textFieldHeigth = 44.0,
      this.textFieldWidth = double.infinity,
      this.outoFouce = false,
      super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.textFieldHeigth.h,
      width: widget.textFieldWidth.w,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        // to control text field
        cursorColor: grayColor,
        autofocus: widget.outoFouce,
        //to return the value that i write it in text field
        onChanged: widget.onChange,
        obscureText: widget.password ? !obscure : obscure,
        //obscuringCharacter: "*",
        keyboardType: widget.inputType,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          fillColor: widget.textFieldColor,

          /// text field background color
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.normal,
            color: widget.hintSyleColor,
          ),
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.password
              ? InkWell(
                  onTap: () => setState(() => obscure = !obscure),
                  child: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    color: grayColor,
                    size: 20.w,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide: BorderSide(
              color: widget.textFieldBorderColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide: BorderSide(
              color: widget.textFieldBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide: BorderSide(
              color: widget.textFieldBorderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide: BorderSide(
              color: widget.textFieldBorderColor,
            ),
          ),
        ),
      ),
    );
  }
}
