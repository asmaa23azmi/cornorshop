import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Fierbase/controllers/user_fb_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../Fierbase/controllers/fb_auth_controller.dart';
import '../../../Fierbase/controllers/fb_storage_controller.dart';
import '../../../Helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Models/fb/img_model.dart';
import '../../../Models/fb/user_model.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Widgets/My_Widgets/my_phone_text_field.dart';
import '../../../Widgets/My_Widgets/my_rich_text.dart';
import '../../../Widgets/My_Widgets/my_text_field.dart';
import '../../../Helper/snack_bar_helper.dart';
import '../../../Helper/img_picker_helper.dart';

class InsertUserPage extends StatefulWidget {
  final UserModel? user;

  const InsertUserPage({this.user, super.key});

  @override
  State<InsertUserPage> createState() => _InsertUserPageState();
}

class _InsertUserPageState extends State<InsertUserPage>
    with SnackBarHelper, ImgPickerHelper, ImgHelper {
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
    nameController = TextEditingController(text: widget.user?.name ?? '');
    phoneNumController =
        TextEditingController(text: widget.user?.phoneNum ?? '');
    emailController = TextEditingController(text: widget.user?.email ?? '');
    addressController = TextEditingController(text: widget.user?.address ?? '');
    passwordController =
        TextEditingController(text: widget.user?.password ?? '');
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
          widget.user == null
              ? AppLocalizations.of(context)!.addUser
              : AppLocalizations.of(context)!.editUser,
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
                    child: profileImg != null
                        ? Image.file(
                            ///pickImg
                            profileImg!,
                            fit: BoxFit.cover,
                          )
                        : appCacheImg(
                            ///previous Img
                            widget.user?.profileImg?.link ?? '',
                            Icon(
                              ///No Img
                              Icons.person,
                              size: 70.h,
                              color: Colors.grey.shade300,
                            ),
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
            widget.user == null
                ? MyTextField(
                    controller: emailController,
                    hintText: AppLocalizations.of(context)!.enterEmail,
                    inputType: TextInputType.emailAddress,
                    textFieldBorderColor: blackObacityColor,
                  )
                : MyTextField(
                    controller: emailController,
                    hintText: AppLocalizations.of(context)!.enterEmail,
                    inputType: TextInputType.emailAddress,
                    textFieldBorderColor: blackObacityColor,
                    isEnabled: false,
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
              text: widget.user == null
                  ? AppLocalizations.of(context)!.addUser
                  : AppLocalizations.of(context)!.editUser,
              buttonColor: greenColor,
              onTap: () async {
                await _performInsert();
                setState(() {});
              },
              loading: loading,
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
  bool loading = false;
  var status = false;

  Future<void> _performInsert() async {
    ///before create account
    if (checkData()) {
      await _insert();
    }
  }

  Future<void> _insert() async {
    setState(() => loading = true);
    try {
      ///Storage
      ImgModel? imgModel;
      if (profileImg != null) {
        if (widget.user?.profileImg != null) {
          ///delete a previous img
          await FbStorageController()
              .deleteFile(widget.user?.profileImg?.path ?? '');
        }
        imgModel = await FbStorageController().uploadFileToStorage(profileImg,
            folderName: 'usersProfileImg/${widget.user?.id}');
      }

      ///FireStore
      widget.user == null
          ? _createUser()
          : status = await UserFbController().updateUser(UserModel(
              id: widget.user?.id,
              name: nameController.text,
              phoneNum: phoneNumController.text,
              email: emailController.text,
              address: addressController.text,
              profileImg:
                  profileImg != null ? imgModel : widget.user?.profileImg,
              password: widget.user?.password,
              sex: widget.user?.sex,
              userType: widget.user?.userType,
              fcm: widget.user?.fcm,
              description: null,
              timestamp: Timestamp.now(),
            ));

      if (status) {
        if (context.mounted) {
          showMySnackBar(context,
              text: widget.user == null
                  ? AppLocalizations.of(context)!.successfulUserAdded
                  : AppLocalizations.of(context)!.successfulUserEdited);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      showMySnackBar(context, text: e.toString());
    }
    setState(() => loading = false);
  }

  Future<void> _createUser() async {
    try {
      ///Auth
      var userCredential = await FbAuthController().register(
          context,email: emailController.text, password: passwordController.text);
      if (userCredential == null) throw Exception('Auth Failed');

      ///FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) throw Exception('FCM Failed');

      ///FireStore
      status = await UserFbController().createUser(UserModel(
        id: userCredential.user!.uid,
        name: nameController.text,
        phoneNum: phoneNumController.text,
        email: emailController.text,
        address: addressController.text,
        password: passwordController.text,
        sex: radioValue,
        //userType: selectedUserType.name,
        profileImg: null,
        description: null,
        fcm: fcmToken,
        timestamp: Timestamp.now(),
      ));
    } catch (e) {
      print(e.toString());
    }
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
    } else if (radioValue == null) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterGender, error: true);
      return false;
    }
    return true;
  }
}
