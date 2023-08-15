import 'package:cornorshop/Fierbase/controllers/user_fb_controller.dart';
import 'package:cornorshop/Providers/style_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:provider/provider.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Fierbase/controllers/fb_auth_controller.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/My_Widgets/my_phone_text_field.dart';
import '../../Widgets/My_Widgets/my_rich_text.dart';
import '../../Widgets/My_Widgets/my_text_field.dart';
import '../../Helper/navigator_helper.dart';
import '../../Chache/cache_controller.dart';
import '../../Screens/Auth/create_new_acount.dart';
import '../../Screens/Auth/reset_password.dart';
import '../../Screens/Bnb_Screens/main_page.dart';
import '../../enums.dart';
import '../../Providers/auth_provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SnackBarHelper, NavigatorHelper {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: AppBar(
      //   elevation: 0.0,
      //
      //   ///delete appBar border
      //   backgroundColor: whiteColor,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: darkBlue,
      //       size: 22.h,
      //     ),
      //   ),
      // ),
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
              // MyRichText(text: AppLocalizations.of(context)!.phoneNum),
              //
              // SizedBox(height: 3.h),
              // MyPhoneTextField(
              //   controller: phoneNumController,
              //   hintText: AppLocalizations.of(context)!.enterPhoneNum,
              //   textFieldBorderColor: blackObacityColor,
              //   country: selectedCountry,
              //   selectedCountryCallBak: ({required country}) {
              //     setState(() => selectedCountry = country);
              //   },
              // ),
              ///Email
              MyRichText(text: AppLocalizations.of(context)!.email),
              SizedBox(height: 3.h),
              MyTextField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.enterEmail,
                textFieldBorderColor: blackObacityColor,
              ),
              SizedBox(height: 12.h),

              ///Password
              SizedBox(height: 16.h),
              MyRichText(text: AppLocalizations.of(context)!.password),

              SizedBox(height: 3.h),
              MyTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.enterPassword,
                textFieldBorderColor: blackObacityColor,
                password: true,
                onSubmitted: (p0) async => await _performLogIn(),
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
                onTap: () async {
                  await _performLogIn();
                },
                loading: loading,
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
  bool loading = false;

  Future<void> _performLogIn() async {
    ///before create account
    if (_checkData()) {
      await _login();
    }
  }

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);
  StyleProvider get _style => Provider.of<StyleProvider>(context, listen: false);

  Future<void> _login() async {
    setState(() => loading = true);
    try {
      var userCredential = await FbAuthController().login(
          email: emailController.text, password: passwordController.text);

      if (userCredential == null) throw Exception('Auth Failed / email already exist');

      ///UserModel from FireStore
      var userModel =
          await UserFbController().getUserInfo(userCredential.user!.uid);

      if (userModel == null) throw Exception('FireStore Error');

      ///Provider
      if (context.mounted) {
        _auth.user = userModel;
      }

      await _auth.login;
      await CacheController()
          .setter(CacheKeys.userId, userCredential.user!.uid);
      if (context.mounted) {
        //TODO: snackBar
        // _style.index = 0;
        print(_auth.user?.email);
      }
    } catch (e) {
      showMySnackBar(context, text: e.toString());
    }
    setState(() => loading = false);
  }

  bool _checkData() {
    ///to check text field
    if (emailController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterEmail, error: true);
      return false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterEmailFormat, error: true);
      return false;
    } else if (passwordController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPassword, error: true);
      return false;
    }
    return true;
  }
}
