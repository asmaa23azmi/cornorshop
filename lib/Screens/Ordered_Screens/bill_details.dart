import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/my_phone_text_field.dart';
import '../../Widgets/my_rich_text.dart';
import '../../Widgets/my_text_field.dart';
import '../../Helper/navigator_helper.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/my_button.dart';
import '../../Screens/Ordered_Screens/order_send_done.dart';

class BillDetailScreen extends StatefulWidget {
  const BillDetailScreen({super.key});

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen>
    with NavigatorHelper, SnackBarHelper {
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');

  late TextEditingController nameController;
  late TextEditingController phoneNumController;
  late TextEditingController addressController;
  late TextEditingController governorateController;
  late TextEditingController orderNotesController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneNumController = TextEditingController();
    addressController = TextEditingController();
    governorateController = TextEditingController();
    orderNotesController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumController.dispose();
    addressController.dispose();
    governorateController.dispose();
    orderNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        toolbarHeight: 70.h,
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
          AppLocalizations.of(context)!.billDetails,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///title
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: orangeColor,
                    size: 8.w,
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Text(
                    AppLocalizations.of(context)!.addDetailsToBuy,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0.sp,
                      color: orangeColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.0.h,
              ),

              /// Full Name
              MyRichText(text: AppLocalizations.of(context)!.fullName),

              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                  controller: nameController,
                  hintText: AppLocalizations.of(context)!.enterFullName,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),

              /// Phone Num
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
              SizedBox(height: 12.h),

              ///the Governorate
              MyRichText(text: AppLocalizations.of(context)!.theGovernorate),

              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                  controller: governorateController,
                  hintText: AppLocalizations.of(context)!.enterGovernorate,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),

              /// Address
              MyRichText(text: AppLocalizations.of(context)!.addressInDetails),

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

              ///Notes
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Text(
                  AppLocalizations.of(context)!.orderNotes,
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              MyTextField(
                controller: orderNotesController,
                hintText: AppLocalizations.of(context)!.enterOrderNotes,
                textFieldBorderColor: blackObacityColor,
                hintSyleColor: blackObacityColor,
                textFieldColor: Colors.transparent,
                maxLines: 6,
                textFieldHeigth: 100,
              ),
              SizedBox(height: 12.h),

              ///Details
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Text(
                  AppLocalizations.of(context)!.noteOne,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                      color: darkBlue),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 52.w),
                child: Text(
                  AppLocalizations.of(context)!.noteTwo,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                      color: darkBlue),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 52.w),
                child: Text(
                  AppLocalizations.of(context)!.noteThree,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                      color: darkBlue),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              ///Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(
                    onTap: () {
                      _performConfirmOrder();
                    },
                    text: AppLocalizations.of(context)!.confirmOrder,
                    myWidth: 135,
                    myHeight: 38,
                    borderBouttonColor: Colors.transparent,
                    buttonColor: orangeColor,
                    myFontSize: 12,
                  ),
                  MyButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: AppLocalizations.of(context)!.cancel,
                    myWidth: 135,
                    myHeight: 38,
                    borderBouttonColor: orangeColor,
                    buttonColor: Colors.transparent,
                    textButtonColor: orangeColor,
                    myFontSize: 12,
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

  void _performConfirmOrder() {
    ///before create account
    if (checkData()) {
      _confirmOrder();
    }
  }

  void _confirmOrder() {
    showMySnackBar(context,
        text: AppLocalizations.of(context)!.sendOrderSuccessfully);
    jump(context, to: const OrderedSendScreen(), replace: true);
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
    } else if (governorateController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterGovernorate, error: true);
      return false;
    } else if (addressController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterAddress, error: true);
      return false;
    }
    return true;
  }
}
