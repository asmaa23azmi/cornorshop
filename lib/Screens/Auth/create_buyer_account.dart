import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:provider/provider.dart';
import '../../Chache/cache_controller.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Providers/auth_provider.dart';
import '../../Providers/style_provider.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/My_Widgets/my_rich_text.dart';
import '../../Widgets/My_Widgets/my_text_field.dart';
import '../../Helper/navigator_helper.dart';
import '../../enums.dart';
import '../Bnb_Screens/main_page.dart';
import '../../Fierbase/controllers/fb_auth_controller.dart';
import '../../Fierbase/controllers/user_fb_controller.dart';
import '../../Models/fb/user_model.dart';
import '../../Screens/Auth/log_in.dart';
import '../../Widgets/My_Widgets/my_phone_text_field.dart';

class CreateBuyerAccount extends StatefulWidget {
  const CreateBuyerAccount({super.key});

  @override
  State<CreateBuyerAccount> createState() => _CreateBuyerAccountState();
}

class _CreateBuyerAccountState extends State<CreateBuyerAccount>
    with SnackBarHelper, NavigatorHelper {
  late TextEditingController nameController;
  late TextEditingController phoneNumController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController passwordController;
  late TextEditingController returnPassController;
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');
  UserType selectedUserType = UserType.buyer;
  String? radioValue;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneNumController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    returnPassController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    returnPassController.dispose();
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
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 30.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.createBuyerAccount,
                  style: textHeaderStyle,
                ),
              ),
              SizedBox(height: 18.h),

              ///Full Name
              MyRichText(text: AppLocalizations.of(context)!.fullName),
              SizedBox(height: 3.0.h),
              MyTextField(
                controller: nameController,
                hintText: AppLocalizations.of(context)!.enterFullName,
                textFieldBorderColor: blackObacityColor,
              ),
              SizedBox(height: 12.h),

              ///Phone Num
              MyRichText(text: AppLocalizations.of(context)!.phoneNum),
              SizedBox(height: 3.0.h),
              MyPhoneTextField(
                controller: phoneNumController,
                hintText: AppLocalizations.of(context)!.enterPhoneNum,
                textFieldBorderColor: blackObacityColor,
                country: selectedCountry,
                selectedCountryCallBak: ({required country}) {
                  setState(() => selectedCountry = country);
                },
              ),
              SizedBox(height: 12.h),

              ///Email
              MyRichText(text: AppLocalizations.of(context)!.email),
              SizedBox(height: 3.h),
              MyTextField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.enterEmail,
                textFieldBorderColor: blackObacityColor,
              ),
              SizedBox(height: 12.h),

              ///Address
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 15,
                ),
                child: Text(
                  AppLocalizations.of(context)!.address,
                  style: textStyle,
                ),
              ),
              SizedBox(height: 3.h),
              MyTextField(
                controller: addressController,
                hintText: AppLocalizations.of(context)!.enterAddress,
                textFieldBorderColor: blackObacityColor,
              ),
              SizedBox(height: 12.h),

              ///Password
              MyRichText(text: AppLocalizations.of(context)!.password),
              SizedBox(height: 3.h),
              MyTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.enterPassword,
                textFieldBorderColor: blackObacityColor,
                password: true,
              ),
              SizedBox(height: 12.h),

              ///Return Pass
              MyRichText(text: AppLocalizations.of(context)!.returnPassword),
              SizedBox(height: 3.h),
              MyTextField(
                controller: returnPassController,
                hintText: AppLocalizations.of(context)!.enterReturnPassword,
                textFieldBorderColor: blackObacityColor,
                password: true,
                onSubmitted: (p0) async => await _performCreate(),
              ),
              SizedBox(height: 12.0.h),

              ///Choose Gender
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'M',
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = value;
                          });
                        },
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        AppLocalizations.of(context)!.male,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'F',
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = value;
                          });
                        },
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        AppLocalizations.of(context)!.female,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              ///Action
              MyButton(
                text: AppLocalizations.of(context)!.createAccount,
                onTap: () async {
                  await _performCreate();
                  setState(() {});
                },
                loading: loading,
              ),
              SizedBox(height: 8.h),

              ///Log In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.haveAccount,
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      color: darkBlue,
                    ),
                  ),
                  SizedBox(width: 4.5.w),
                  InkWell(
                    onTap: () {
                      jump(context, to: const LogIn());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
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

  Future<void> _performCreate() async {
    ///before create account
    if (_checkData()) {
      await _create();
    }
  }

  Future<void> _create() async {
    setState(() => loading = true);
    try {
      ///Auth
      var userCredential = await FbAuthController().register(
         context, email: emailController.text, password: passwordController.text);
      if (userCredential == null) throw Exception('Auth Failed');

      ///Storage (img != null)
      ///FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) throw Exception('FCM Failed');

      ///FireStore
      var fireStoreResult = await UserFbController().createUser(UserModel(
        id: userCredential.user!.uid,
        name: nameController.text,
        phoneNum: phoneNumController.text,
        email: emailController.text,
        address: addressController.text,
        password: passwordController.text,
        sex: radioValue,
        userType: selectedUserType.name,
        profileImg: null,
        description: null,
        fcm: fcmToken,
        timestamp: Timestamp.now(),
      ));
      if (!fireStoreResult) throw Exception('FireStore Failed');

      ///Pop
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        //jump(context, to: const MainPage(), replace: true);
        showMySnackBar(context,
            text: AppLocalizations.of(context)!.createdSuccessfully);
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() => loading = false);
  }

  bool _checkData() {
    ///to check text field
    if (nameController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterFullName, error: true);
      return false;
    } else if (phoneNumController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPhoneNum, error: true);
      return false;
    } else if (emailController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterEmail, error: true);
      return false;
    }  else if (passwordController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPassword, error: true);
      return false;
    }  else if (returnPassController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterReturnPassword, error: true);
      return false;
    } else if (passwordController.text != returnPassController.text) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.notMatchPass, error: true);
      return false;
    } else if (radioValue == null) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterGender, error: true);
      return false;
    }
    return true;
  }
}
