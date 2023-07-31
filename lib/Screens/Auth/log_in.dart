import 'package:cornorshop/Screens/Auth/create_new_acount.dart';
import 'package:cornorshop/Screens/Auth/reset_password.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/My_Widgets/my_phone_text_field.dart';
import '../../Widgets/My_Widgets/my_rich_text.dart';
import '../../Widgets/My_Widgets/my_text_field.dart';
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
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.0,

        ///delete appBar border
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
          padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 100.0.h),
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
              SizedBox(height: 40.h),

              ///Phone Num
              MyRichText(text: AppLocalizations.of(context)!.phoneNum),

              SizedBox(height: 3.h),
              MyPhoneTextField(
                controller: phoneNumController,
                hintText: AppLocalizations.of(context)!.enterPhoneNum,
                textFieldBorderColor: blackObacityColor,
                country: selectedCountry,
                selectedCountryCallBak: ({required country}) {
                  setState(() => selectedCountry = country);
                },
              ),

              ///Password
              SizedBox(height: 16.h),
              MyRichText(text: AppLocalizations.of(context)!.password),

              SizedBox(height: 3.h),
              MyTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.enterPassword,
                textFieldBorderColor: blackObacityColor,
                password: true,
              ),
              SizedBox(height: 10.h),

              ///Are You Forget Password
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  jump(context, to: const ResetPassword());
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 15.w),
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassQuestion,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: greenColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              ///Action
              MyButton(
                text: AppLocalizations.of(context)!.login,
                onTap: () async{
                  await _performLogIn();
                },
              ),
              SizedBox(height: 10.h),

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
                  SizedBox(width: 4.5.w),
                  InkWell(
                    onTap: () {
                      jump(context, to: const CreateNewAccount());
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      AppLocalizations.of(context)!.createAccount,
                      style: TextStyle(
                          fontSize: 15.0.sp,
                          color: greenColor,
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

  Future<void> _performLogIn() async{
    ///before create account
    if (checkData()) {
      await _login();
    }
  }

  Future<void> _login() async{}

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
