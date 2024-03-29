import 'package:cornorshop/Screens/Auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/My_Widgets/my_rich_text.dart';
import '../../Widgets/My_Widgets/my_text_field.dart';
import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    with SnackBarHelper, NavigatorHelper {
  late TextEditingController currentPassController;
  late TextEditingController newPassController;
  late TextEditingController confirmPassController;

  @override
  void initState() {
    currentPassController = TextEditingController();
    newPassController = TextEditingController();
    confirmPassController = TextEditingController();
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
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 22.h,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 50.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Center(
                child: Text(
                  AppLocalizations.of(context)!.changePassword,
                  style: textHeaderStyle,
                ),
              ),
              SizedBox(height: 30.h),

              ///Current Password
              MyRichText(text: AppLocalizations.of(context)!.currentPassword),
              SizedBox(height: 3.h),
              MyTextField(
                controller: currentPassController,
                hintText: AppLocalizations.of(context)!.enterCurrentPassword,
                password: true,
                textFieldBorderColor: blackObacityColor,
              ),
              SizedBox(height: 20.h),

              ///New Password
              MyRichText(text: AppLocalizations.of(context)!.newPassword),
              SizedBox(height: 3.h),
              MyTextField(
                controller: newPassController,
                hintText: AppLocalizations.of(context)!.enterNewPassword,
                textFieldBorderColor: blackObacityColor,
                password: true,
              ),
              SizedBox(height: 20.h),

              ///Confirm New Password
              MyRichText(
                  text: AppLocalizations.of(context)!.confirmNewPassword),

              SizedBox(height: 3.h),
              MyTextField(
                controller: confirmPassController,
                hintText: AppLocalizations.of(context)!.enterReturnPassword,
                textFieldBorderColor: blackObacityColor,
                password: true,
              ),
              SizedBox(height: 30.h),

              ///Confirm Action
              MyButton(
                text: AppLocalizations.of(context)!.changePassword,
                onTap: () async{
                  await _performChangePass();
                },
              ),
              SizedBox(height: 20.h),

              ///Cancel Action
              MyButton(
                  text: AppLocalizations.of(context)!.cancel,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  buttonColor: Colors.transparent,
                  textButtonColor: darkBlue,
                  borderBouttonColor: darkBlue),
              SizedBox(height: 12.h),

              ///Are You Forget Password
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  jump(context, to: const ResetPassword());
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 15.w,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassQuestion,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0.sp,
                      color: greenColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performChangePass() async{
    ///before create account
    if (checkData()) {
     await _changePass();
    }
  }

  Future<void> _changePass() async{}

  bool checkData() {
    ///to check text field
    if (currentPassController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterCurrentPassword,
          error: true);
      return false;
    } else if (newPassController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterNewPassword, error: true);
      return false;
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
        .hasMatch(newPassController.text)) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPassFormat, error: true);
      return false;
    } else if (confirmPassController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterReturnPassword, error: true);
      return false;
    } else if (newPassController.text != confirmPassController.text) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.notMatchPass, error: true);
      return false;
    }
    return true;
  }
}
