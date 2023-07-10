import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/my_phone_text_field.dart';
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

class _BillDetailScreenState extends State<BillDetailScreen> with NavigatorHelper, SnackBarHelper{
  late AppLocalizations appLocale = AppLocalizations.of(context)!;
  CountryModel selectedCountry = appCountries.firstWhere((element) => element.dialCode == '970');

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
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: babyBlue,
        toolbarHeight: 124.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              bottomEnd:Radius.circular(20.r),
              bottomStart: Radius.circular(20.r)),
        ),
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back_ios,
            color: darkBlue,
            size: 24.0.h,),),
        centerTitle: true,
        title: Text(appLocale.billDetails, style: textAppBarStyle,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
          physics:const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///title
              Row(children: [
                Icon(Icons.arrow_back_ios, color: darkBlue, size: 8.w,),
                SizedBox(width: 7.w,),
                Text(appLocale.addDetailsToBuy, style: textStyle,)
              ],),
              SizedBox(height: 6.0.h,),
              /// Full Name
              _richText(appLocale.fullName),
              SizedBox(height: 3.0.h,),
              MyTextField(controller: nameController, hintText: appLocale.enterFullName,
              textFieldBorderColor: blackObacityColor, hintSyleColor: blackObacityColor, textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),
              /// Phone Num
              _richText(appLocale.phoneNum),
              SizedBox(height: 3.0.h,),
              MyPhoneTextField(controller: phoneNumController, hintText: appLocale.enterPhoneNum,
                textFieldBorderColor: blackObacityColor, hintSyleColor: blackObacityColor, textFieldColor: Colors.transparent,
                country: selectedCountry, selectedCountryCallBak: ({required country}) {
                  setState(() => selectedCountry = country);
                },),
              SizedBox(height: 12.h),
              ///the Governorate
              _richText(appLocale.theGovernorate),
              SizedBox(height: 3.0.h,),
              MyTextField(controller: governorateController, hintText:  appLocale.enterGovernorate,
                  textFieldBorderColor: blackObacityColor, hintSyleColor: blackObacityColor, textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),
              /// Address
              _richText(appLocale.addressInDetails),
              SizedBox(height: 3.0.h,),
              MyTextField(controller: addressController, hintText: appLocale.enterAddress,
                  textFieldBorderColor: blackObacityColor, hintSyleColor: blackObacityColor, textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),
              ///Notes
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Text(appLocale.orderNotes, style:textStyle,),
              ),
              SizedBox(height: 3.0.h,),
              MyTextField(controller: orderNotesController, hintText: appLocale.enterOrderNotes,
                  textFieldBorderColor: blackObacityColor, hintSyleColor: blackObacityColor, textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),
              ///Details
              Padding(
                  padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Text(appLocale.noteOne, style: TextStyle(
                  fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: darkBlue),),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 52.w),
                child: Text(appLocale.noteTwo ,style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: darkBlue),),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 52.w),
                child: Text(appLocale.noteThree ,style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: darkBlue),),
              ),
              SizedBox(height: 40.h,),
              ///Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(onTap:(){_performConfirmOrder();  },
                      text: appLocale.confirmOrder, myWidth: 135.w,
                      borderBouttonColor: Colors.transparent, buttonColor: orangeColor),
                  MyButton(onTap:(){Navigator.pop(context);},text: appLocale.cancel, myWidth: 135.w,
                      borderBouttonColor: orangeColor, buttonColor: Colors.transparent, textButtonColor: orangeColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Functions
  Widget _richText(String textTitle){
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 15.w),
      child: RichText(
        text: TextSpan(
          text: textTitle,
          style:textStyle,
          children: [textSpain],
        ),),
    );
  }
  void _performConfirmOrder(){
    ///before create account
    if (checkData()){
      _confirmOrder();
    }
  }
  void _confirmOrder(){
    showMySnackBar(context, text: appLocale.sendOrderSuccessfully);
    jump(context, to: const OrderedSendScreen(), replace: true);
  }
  bool checkData(){
    ///to check text field
    if (nameController.text.isEmpty){
      showMySnackBar(context, text: appLocale.enterFullName, error: true);
      return false;
    }else  if (phoneNumController.text.isEmpty){
      showMySnackBar(context, text: appLocale.enterPhoneNum, error: true);
      return false;
    } else  if (governorateController.text.isEmpty){
      showMySnackBar(context, text: appLocale.enterGovernorate, error: true);
      return false;
    }else  if (addressController.text.isEmpty){
      showMySnackBar(context, text: appLocale.enterGovernorate, error: true);
      return false;
    }
    return true;
  }
}
