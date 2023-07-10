import 'package:cornorshop/Screens/Auth/create_new_acount.dart';
import 'package:cornorshop/Screens/Auth/reset_password.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/my_button.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/my_phone_text_field.dart';
import '../../Widgets/my_text_field.dart';
import '../../Helper/navigator_helper.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SnackBarHelper, NavigatorHelper {
  late TextEditingController phoneNumController;
  late TextEditingController passwordController;
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');

  @override
  void initState() {
    phoneNumController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: babyBlue,
      appBar: AppBar(
        elevation: 0.0,

        ///delete appBar border
        backgroundColor: babyBlue,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 24.0.h,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 100.0.h),
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header Text
              Center(
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: textHeaderStyle,
                ),
              ),
              SizedBox(
                height: 40.0.h,
              ),

              ///Phone Num
              _richText(AppLocalizations.of(context)!.phoneNum),
              SizedBox(
                height: 3.0.h,
              ),
              MyPhoneTextField(
                controller: phoneNumController,
                hintText: AppLocalizations.of(context)!.enterPhoneNum,
                country: selectedCountry,
                selectedCountryCallBak: ({required country}) {
                  setState(() => selectedCountry = country);
                },
              ),

              ///Password
              SizedBox(
                height: 16.0.h,
              ),
              _richText(AppLocalizations.of(context)!.password),
              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.enterPassword,
                password: true,
              ),
              SizedBox(
                height: 10.0.h,
              ),

              ///Are You Forget Password
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  jump(context, to: ResetPassword());
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 15.w),
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassQuestion,
                    style: TextStyle(
                      fontSize: 13.0.sp,
                      color: orangeColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),

              ///Action
              MyButton(
                text: AppLocalizations.of(context)!.login,
                onTap: () {
                  _performLogIn();
                },
              ),
              SizedBox(
                height: 10.0.h,
              ),

              ///Create Account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.doNotHaveAccount,
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      color: darkBlue,
                    ),
                  ),
                  SizedBox(
                    width: 4.5.w,
                  ),
                  InkWell(
                    onTap: () {
                      jump(context, to: CreateNewAccount());
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      AppLocalizations.of(context)!.createAccount,
                      style: TextStyle(
                          fontSize: 15.0.sp,
                          color: orangeColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Functions
  Widget _richText(String textTitle) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 15.sp),
      child: RichText(
        text: TextSpan(
          text: textTitle,
          style: textStyle,
          children: [textSpain],
        ),
      ),
    );
  }

  void _performLogIn() {
    ///before create account
    if (checkData()) {
      _login();
    }
  }

  void _login() {}

  bool checkData() {
    ///to check text field
    if (phoneNumController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPhoneNum, error: true);
      return false;
    } else if (passwordController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPassword, error: true);
      return false;
    }
    return true;
  }
}
