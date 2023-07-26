import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Const/colors.dart';
import '../../../../Const/texts.dart';
import '../../../../Widgets/my_button.dart';
import '../../../../Helper/navigator_helper.dart';


class ProductPaymentMethodPage extends StatefulWidget {
  const ProductPaymentMethodPage({super.key});

  @override
  State<ProductPaymentMethodPage> createState() =>
      _ProductPaymentMethodPageState();
}

class _ProductPaymentMethodPageState
    extends State<ProductPaymentMethodPage> with NavigatorHelper {
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
          AppLocalizations.of(context)!.addPaymentInfo,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 45.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.lock_outline_rounded,
                size: 22.h,
                color: Colors.black.withOpacity(0.55),),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.paymentParagraph,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black.withOpacity(0.55),
                  ),
                ),
              ),
              const Spacer(),
              MyButton(
                  onTap: () {},
                  text: AppLocalizations.of(context)!.requestPromotion,
                  buttonColor: greenColor),
            ],
          ),
        ),
      ),
    );
  }
}
