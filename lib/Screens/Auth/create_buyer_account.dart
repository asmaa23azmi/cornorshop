import '../../Screens/Auth/log_in.dart';
import '../../Widgets/My_Widgets/my_phone_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/My_Widgets/my_rich_text.dart';
import '../../Widgets/My_Widgets/my_text_field.dart';
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
              ),
              SizedBox(height: 30.h),

              ///Action
              MyButton(
                text: AppLocalizations.of(context)!.createAccount,
                onTap: () async{
                  await _performCreate();
                  setState(() {});
                },
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

  Future<void> _performCreate() async{
    ///before create account
    if (checkData()) {
      await _create();
    }
  }

  Future<void> _create() async{
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
