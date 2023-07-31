import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Helper/navigator_helper.dart';
import '../../Screens/Auth/create_buyer_account.dart';
import '../../Screens/Auth/create_vendor_account.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount>
    with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.0,

        ///delete appBar border
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
          padding: EdgeInsetsDirectional.only(
              top: 109.0.h, start: 14.0.w, end: 14.0.w),
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.createNewAccount,

                /// Text
                style: textHeaderStyle,
              ),
              SizedBox(
                height: 79.0.h,
              ),
              MyButton(
                text: AppLocalizations.of(context)!.createVendorAccount,
                onTap: () {
                  jump(context, to: const CreateVendorAccount());
                },
              ),
              SizedBox(
                height: 60.0.h,
              ),
              MyButton(
                text: AppLocalizations.of(context)!.createBuyerAccount,
                onTap: () {
                  jump(context, to: const CreateBuyerAccount());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
