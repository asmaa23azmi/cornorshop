import 'dart:io';
import 'package:cornorshop/Widgets/My_Widgets/my_dropdown_search.dart';
import 'package:cornorshop/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Widgets/My_Widgets/my_phone_text_field.dart';
import '../../../Widgets/My_Widgets/my_rich_text.dart';
import '../../../Widgets/My_Widgets/my_text_field.dart';
import '../../../Helper/snack_bar_helper.dart';
import '../../../Helper/img_picker_helper.dart';

class InsertUserPage extends StatefulWidget {
  const InsertUserPage({super.key});

  @override
  State<InsertUserPage> createState() => _InsertUserPageState();
}

class _InsertUserPageState extends State<InsertUserPage>
    with SnackBarHelper, ImgPickerHelper {
  late TextEditingController nameController;
  late TextEditingController phoneNumController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController passwordController;
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');
  String? radioValue;
  File? profileImg;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneNumController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        title: Text(
          AppLocalizations.of(context)!.addUser,
          style: textAppBarStyle,
        ),
        centerTitle: true,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 22.h,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Profile Image
            Center(
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: profileImg == null
                        ? Icon(
                            Icons.person,
                            size: 70.h,
                            color: Colors.grey.shade300,
                          )
                        : Image.file(
                            profileImg!,
                            fit: BoxFit.cover,
                          ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      profileImg = await pickImageFromGallery();
                      setState(() {});
                    },
                    child: Text(
                      AppLocalizations.of(context)!.userImg,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            ///Full Name
            MyRichText(text: AppLocalizations.of(context)!.fullName),
            SizedBox(height: 3.0.h),
            MyTextField(
              controller: nameController,
              hintText: AppLocalizations.of(context)!.enterFullName,
              textFieldBorderColor: blackObacityColor,
            ),
            SizedBox(height: 12.h),
            ///UserType
            MyRichText(text: AppLocalizations.of(context)!.userType),
            SizedBox(height: 3.0.h),
              //ToDo: create a userType
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
            SizedBox(height: 3.0.h),
            MyTextField(
              controller: emailController,
              hintText: AppLocalizations.of(context)!.enterEmail,
              inputType: TextInputType.emailAddress,
              textFieldBorderColor: blackObacityColor,
            ),
            SizedBox(height: 12.h),

            ///Address
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 15.w,
              ),
              child: Text(
                AppLocalizations.of(context)!.address,
                style: textStyle,
              ),
            ),
            SizedBox(height: 3.0.h),
            MyTextField(
              controller: addressController,
              hintText: AppLocalizations.of(context)!.enterAddress,
              textFieldBorderColor: blackObacityColor,
            ),
            SizedBox(height: 12.h),

            ///Password
            MyRichText(text: AppLocalizations.of(context)!.password),
            SizedBox(height: 3.0.h),
            MyTextField(
              controller: passwordController,
              hintText: AppLocalizations.of(context)!.enterPassword,
              textFieldBorderColor: blackObacityColor,
              password: true,
            ),
            SizedBox(height: 12.h),

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

            ///Confirm Action
            MyButton(
              text: AppLocalizations.of(context)!.addUser,
              buttonColor: greenColor,
              onTap: () async {
                await _performInsert();
                setState(() {});
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
                textButtonColor: greenColor,
                borderBouttonColor: greenColor),
          ],
        ),
      ),
    );
  }

  ///Functions

  Future<void> _performInsert() async {
    ///before create account
    if (checkData()) {
      await _insert();
    }
  }

  Future<void> _insert() async {}

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
    } else if (radioValue == null) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterGender, error: true);
      return false;
    }
    return true;
  }
}
