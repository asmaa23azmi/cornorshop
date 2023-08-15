import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../Helper/image_helper.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../../Helper/snack_bar_helper.dart';
import '../../../Widgets/My_Widgets/my_rich_text.dart';
import '../../../Widgets/My_Widgets/my_text_field.dart';
import '../../Widgets/My_Widgets/my_phone_text_field.dart';
import '../../Helper/img_picker_helper.dart';
import '../../Providers/auth_provider.dart';
import '../../../Fierbase/controllers/fb_storage_controller.dart';
import '../../../Fierbase/controllers/user_fb_controller.dart';
import '../../../Models/fb/img_model.dart';
import '../../../Models/fb/user_model.dart';

class EditVendorProfile extends StatefulWidget {
  const EditVendorProfile({super.key});

  @override
  State<EditVendorProfile> createState() => _EditVendorProfileState();
}

class _EditVendorProfileState extends State<EditVendorProfile>
    with SnackBarHelper, ImgPickerHelper, ImgHelper {
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');
  late TextEditingController userNameController;
  late TextEditingController phoneNumController;
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: _auth.user?.name ?? '');
    phoneNumController =
        TextEditingController(text: _auth.user?.phoneNum ?? '');
    bioController = TextEditingController(text: _auth.user?.description ?? '');
    emailController = TextEditingController(text: _auth.user?.email ?? '');
    addressController = TextEditingController(text: _auth.user?.address ?? '');
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneNumController.dispose();
    bioController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  File? profileImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 22.h,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.editProfile,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                              _auth.user?.profileImg?.link ?? '',
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
                        AppLocalizations.of(context)!.editVendorImg,
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

              ///User Name
              MyRichText(text: AppLocalizations.of(context)!.userName),
              SizedBox(height: 3.h),
              MyTextField(
                  controller: userNameController,
                  hintText: AppLocalizations.of(context)!.enterUserName,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),

              ///Phone Number
              MyRichText(text: AppLocalizations.of(context)!.phoneNum),

              SizedBox(height: 3.0.h),
              MyPhoneTextField(
                controller: phoneNumController,
                hintText: AppLocalizations.of(context)!.enterPhoneNum,
                textFieldBorderColor: blackObacityColor,
                hintSyleColor: blackObacityColor,
                textFieldColor: Colors.transparent,
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
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent,
                  isEnabled: false),
              SizedBox(height: 12.h),

              /// Address

              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
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
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),

              ///Bio
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Text(
                  AppLocalizations.of(context)!.bio,
                  style: textStyle,
                ),
              ),
              SizedBox(height: 3.h),
              MyTextField(
                controller: bioController,
                hintText: AppLocalizations.of(context)!.enterBio,
                textFieldBorderColor: blackObacityColor,
                hintSyleColor: blackObacityColor,
                textFieldColor: Colors.transparent,
                maxLines: 6,
                textFieldHeigth: 100.h,
              ),
              SizedBox(height: 34.h),

              ///Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(
                    onTap: () async {
                      await _performConfirm();
                    },
                    text: AppLocalizations.of(context)!.save,
                    myWidth: 135,
                    myHeight: 38,
                    myFontSize: 12.sp,
                    borderBouttonColor: Colors.transparent,
                    buttonColor: greenColor,
                    loading: loading,
                  ),
                  MyButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: AppLocalizations.of(context)!.cancel,
                      myWidth: 135,
                      myHeight: 38,
                      myFontSize: 12.sp,
                      borderBouttonColor: greenColor,
                      buttonColor: Colors.transparent,
                      textButtonColor: greenColor),
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

  Future<void> _performConfirm() async {
    ///before create account
    if (checkData()) {
      await _confirm();
    }
  }

  Future<void> _confirm() async {
    setState(() => loading = true);
    try {
      ///Storage
      ImgModel? imgModel;
      if (profileImg != null) {
        if(_auth.user?.profileImg != null){
          ///delete a previous img
          await FbStorageController().deleteFile(_auth.user?.profileImg?.path ?? '');
        }
        imgModel = await FbStorageController().uploadFileToStorage(profileImg,
            folderName: 'usersProfileImg/${_auth.user?.id}');
      }

      ///FireStore
      var status = await UserFbController().updateUser(_userModel(imgModel));

      if (status) {
        _auth.user = _userModel(imgModel);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      showMySnackBar(context, text: e.toString());
    }
    setState(() => loading = false);
  }

  ///this model for update user and separate it to update data in provider to avoid duplicate the code
  UserModel _userModel(ImgModel? imgModel) {
    return UserModel(
      id: _auth.user?.id,
      name: userNameController.text,
      phoneNum: phoneNumController.text,
      email: emailController.text,
      address: addressController.text,
      profileImg: profileImg != null ? imgModel : _auth.user?.profileImg,
      password: _auth.user?.password,
      sex: _auth.user?.sex,
      userType: _auth.user?.userType,
      fcm: _auth.user?.fcm,
      description: bioController.text,
      timestamp: Timestamp.now(),
    );
  }

  bool checkData() {
    ///to check text field
    if (userNameController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterUserName, error: true);
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
    }
    return true;
  }
}
