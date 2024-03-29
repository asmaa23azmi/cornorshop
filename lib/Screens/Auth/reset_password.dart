import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Widgets/My_Widgets/my_phone_text_field.dart';
import '../../Widgets/My_Widgets/my_rich_text.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with SnackBarHelper {
  late TextEditingController phoneNumController;
  CountryModel selectedCountry =
      appCountries.firstWhere((element) => element.dialCode == '970');

  @override
  void initState() {
    phoneNumController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumController.dispose();
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
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: 14.0.w, vertical: 109.h),
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Text
              Center(
                child: Text(
                  AppLocalizations.of(context)!.resetPassword,
                  style: textHeaderStyle,
                ),
              ),
              SizedBox(
                height: 57.h,
              ),

              /// Phone Num
              MyRichText(text: AppLocalizations.of(context)!.phoneNum),
              SizedBox(height: 3.h),
              MyPhoneTextField(
                controller: phoneNumController,
                hintText: AppLocalizations.of(context)!.enterPhoneNum,
                textFieldBorderColor: blackObacityColor,
                country: selectedCountry,
                selectedCountryCallBak: ({required country}) {
                  setState(() => selectedCountry = country);
                },
              ),
              SizedBox(height: 30.h),

              ///Action
              MyButton(
                text: AppLocalizations.of(context)!.resetPassword,
                onTap: () async{
                  await _performResetPass();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performResetPass() async{
    ///before create account
    if (checkData()) {
      await _resetPass();
    }
  }

  Future<void> _resetPass() async{}

  bool checkData() {
    ///to check text field
    if (phoneNumController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterPhoneNum, error: true);
      return false;
    }
    return true;
  }
}
