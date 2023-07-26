import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Widgets/my_button.dart';
import '../../../Helper/snack_bar_helper.dart';
import '../../../Widgets/my_rich_text.dart';
import '../../../Widgets/my_text_field.dart';
import '../../Widgets/my_phone_text_field.dart';
import '../../Helper/img_picker_helper.dart';

class EditVendorProfile extends StatefulWidget {
  const EditVendorProfile({super.key});

  @override
  State<EditVendorProfile> createState() => _EditVendorProfileState();
}

class _EditVendorProfileState extends State<EditVendorProfile>
    with SnackBarHelper, ImgPickerHelper {
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');
  late TextEditingController userNameController;
  late TextEditingController phoneNumController;
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    phoneNumController = TextEditingController();
    bioController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        //toolbarHeight: 70.h,
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
                        await pickImgFromGallery();
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
              SizedBox(
                height: 12.h,
              ),

              ///User Name
              MyRichText(text: AppLocalizations.of(context)!.userName),
              SizedBox(
                height: 3.h,
              ),
              MyTextField(
                  controller: userNameController,
                  hintText: AppLocalizations.of(context)!.enterUserName,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(
                height: 12.h,
              ),

              ///Phone Number
              MyRichText(text: AppLocalizations.of(context)!.phoneNum),

              SizedBox(
                height: 3.0.h,
              ),
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
              SizedBox(
                height: 12.h,
              ),

              ///Email
              MyRichText(text: AppLocalizations.of(context)!.email),
              SizedBox(
                height: 3.h,
              ),
              MyTextField(
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.enterEmail,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(
                height: 12.h,
              ),

              /// Address

              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
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
              SizedBox(
                height: 3.h,
              ),
              MyTextField(
                controller: bioController,
                hintText: AppLocalizations.of(context)!.enterBio,
                textFieldBorderColor: blackObacityColor,
                hintSyleColor: blackObacityColor,
                textFieldColor: Colors.transparent,
                maxLines: 6,
                textFieldHeigth: 100.h,
              ),
              SizedBox(
                height: 34.h,
              ),

              ///Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(
                      onTap: () {
                        _performConfirm();
                      },
                      text: AppLocalizations.of(context)!.save,
                      myWidth: 135,
                      myHeight: 38,
                      myFontSize: 12.sp,
                      borderBouttonColor: Colors.transparent,
                      buttonColor: greenColor),
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

  void _performConfirm() {
    ///before create account
    if (checkData()) {
      _confirm();
    }
  }

  void _confirm() {}

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
