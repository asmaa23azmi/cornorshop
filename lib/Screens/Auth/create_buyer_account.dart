import 'package:cornorshop/Screens/Auth/log_in.dart';
import 'package:cornorshop/Widgets/my_phone_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/my_button.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/my_rich_text.dart';
import '../../Widgets/my_text_field.dart';
import '../../Helper/navigator_helper.dart';

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
      backgroundColor: babyBlue,
      appBar: AppBar(
        elevation: 0.0,
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
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 30.h),
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
              SizedBox(
                height: 18.h,
              ),

              ///Full Name
              MyRichText(text: AppLocalizations.of(context)!.fullName),
              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                controller: nameController,
                hintText: AppLocalizations.of(context)!.enterFullName,
              ),
              SizedBox(
                height: 12.h,
              ),

              ///Phone Num
              MyRichText(text: AppLocalizations.of(context)!.phoneNum),
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
              SizedBox(
                height: 12.h,
              ),

              ///Email
              MyRichText(text: AppLocalizations.of(context)!.email),
              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.enterEmail,
              ),
              SizedBox(
                height: 12.h,
              ),

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
              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                controller: addressController,
                hintText: AppLocalizations.of(context)!.enterAddress,
              ),
              SizedBox(
                height: 12.h,
              ),

              ///Password
              MyRichText(text: AppLocalizations.of(context)!.password),
              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.enterPassword,
                password: true,
              ),
              SizedBox(
                height: 12.h,
              ),

              ///Return Pass
              MyRichText(text: AppLocalizations.of(context)!.returnPassword),
              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                controller: returnPassController,
                hintText: AppLocalizations.of(context)!.enterReturnPassword,
                password: true,
              ),
              SizedBox(
                height: 30.0.h,
              ),

              ///Action
              MyButton(
                text: AppLocalizations.of(context)!.createAccount,
                onTap: () {
                  _performCreate();
                  setState(() {});
                },
              ),
              SizedBox(
                height: 8.h,
              ),

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
                      jump(context, to: LogIn());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
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

  void _performCreate() {
    ///before create account
    if (checkData()) {
      _create();
    }
  }

  void _create() {
    showMySnackBar(context,
        text: AppLocalizations.of(context)!.createdSuccessfully);
  }

  bool checkData() {
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
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
        .hasMatch(passwordController.text)) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPassFormat, error: true);
      return false;
    } else if (returnPassController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterReturnPassword, error: true);
      return false;
    }
    return true;
  }
}
