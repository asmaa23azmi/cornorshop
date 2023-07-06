import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/my_button.dart';
import '../../Const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/my_text_field.dart';
import '../../Const/texts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with SnackBarHelper{
  late TextEditingController currentPassController;
  late TextEditingController newPassController;
  late TextEditingController confirmPassController;

  @override
  void initState() {
    currentPassController =TextEditingController();
    newPassController =TextEditingController();
    confirmPassController =TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    /// to remove data when we leave the page
    currentPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: babyBlue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: babyBlue,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,
          color: darkBlue,
          size: 24.0.h,
          ),
        ),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Center(
                child: Text(AppLocalizations.of(context)!.changePassword,
                style: textHeaderStyle,),
              ),
               SizedBox(height: 30.h,),
              ///Current Password
              _richText(AppLocalizations.of(context)!.currentPassword),
               SizedBox(height: 3.h,),
              MyTextField(controller: currentPassController,
                  hintText: AppLocalizations.of(context)!.enterCurrentPassword, password: true,),
              SizedBox(height: 20.h,),
              ///New Password
              _richText(AppLocalizations.of(context)!.newPassword),
              SizedBox(height: 3.h,),
              MyTextField(controller: newPassController,
                  hintText: AppLocalizations.of(context)!.enterNewPassword, password: true,),
               SizedBox(height: 20.h,),
              ///Confirm New Password
              _richText(AppLocalizations.of(context)!.confirmNewPassword),
              SizedBox(height: 3.h,),
              MyTextField(controller: confirmPassController,
                  hintText: AppLocalizations.of(context)!.enterReturnPassword, password: true,),
              SizedBox(height: 30.h,),
              ///Confirm Action
              MyButton(text: AppLocalizations.of(context)!.changePassword ,
                onTap: (){
                  _performChangePass();
                },),
               SizedBox(height: 20.h,),
              ///Cancel Action
              MyButton(text: AppLocalizations.of(context)!.cancel , onTap: (){},
                buttonColor: Colors.transparent, textButtonColor: darkBlue),
               SizedBox(height: 12.h,),
              ///Are You Forget Password
            InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){},
                child: Padding(
                  padding:  EdgeInsetsDirectional.only(start: 15.w,),
                  child: Text(AppLocalizations.of(context)!.forgetPassQuestion,
                  style:  TextStyle(
                      fontSize: 13.0.sp,
                    color: orangeColor,
                  ),),
                ),),
            ],
          ),
        ),
      ),
    );
  }
  Widget _richText(String txtTitle){
    return Padding(
      padding:  EdgeInsetsDirectional.only(start: 15.w),
      child: RichText(
          text: TextSpan(
        text: txtTitle,
        style: textStyle,
        children: [textSpain]
      )),
    );
  }
  void _performChangePass(){
    ///before create account
    if (checkData()){
      _changePass();
    }
  }
  void _changePass(){
  }
  bool checkData(){
    ///to check text field
    if (currentPassController.text.isEmpty){
      showMySnackBar(context, text: AppLocalizations.of(context)!.enterCurrentPassword, error: true);
      return false;
    }else  if (newPassController.text.isEmpty){
      showMySnackBar(context, text: AppLocalizations.of(context)!.enterNewPassword, error: true);
      return false;
    }else if(!RegExp( r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
        .hasMatch(newPassController.text)){
      showMySnackBar(context, text: AppLocalizations.of(context)!.enterPassFormat, error: true);
      return false;
    } else  if (confirmPassController.text.isEmpty){
      showMySnackBar(context, text: AppLocalizations.of(context)!.enterReturnPassword, error: true);
      return false;
    }
    return true;
  }
}
