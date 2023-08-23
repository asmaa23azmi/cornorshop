import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/colors.dart';

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
  final double myFontSize;
  final Function(String)? onSubmitted;
  final bool isEnabled;
  final TextInputAction textInputAction;

  const MyTextField(
      {required this.controller,
      required this.hintText,
      this.password = false,
      this.prefixIcon,
      this.textFieldColor = whiteColor,
      this.textFieldBorderColor = Colors.transparent,
      this.inputType = TextInputType.text,
      this.onChange,
      this.hintSyleColor = greyColor,
      this.maxLines = 1,
      this.textFieldHeigth = 44.0,
      this.textFieldWidth = double.infinity,
      this.outoFouce = false,
      this.myFontSize = 14,
      this.onSubmitted,
      this.isEnabled = true,
      this.textInputAction = TextInputAction.done,
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
        cursorColor: greyColor,
        autofocus: widget.outoFouce,
        //to return the value that i write it in text field
        onChanged: widget.onChange,
        obscureText: widget.password ? !obscure : obscure,
        //obscuringCharacter: "*",
        keyboardType: widget.inputType,
        maxLines: widget.maxLines,
        onFieldSubmitted: widget.onSubmitted,
        enabled: widget.isEnabled,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          fillColor: widget.textFieldColor,

          /// text field background color
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: widget.myFontSize.sp,
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
                    color: greyColor,
                    size: 20.w,
                  ),
                )
              : null,
          enabledBorder: buildOutlineInputBorder(),
          disabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          errorBorder:buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(
            color: widget.textFieldBorderColor,
          ),
        );
  }
}
