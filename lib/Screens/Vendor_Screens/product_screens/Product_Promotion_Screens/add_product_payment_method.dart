import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Const/colors.dart';
import '../../../../Const/texts.dart';
import '../../../../Widgets/my_button.dart';
import '../../../../Helper/navigator_helper.dart';
import '../../../../Screens/Vendor_Screens/product_screens/Product_Promotion_Screens/product_payment_method.dart';

class AddProductPaymentMethodPage extends StatefulWidget {
  const AddProductPaymentMethodPage({super.key});

  @override
  State<AddProductPaymentMethodPage> createState() =>
      _AddProductPaymentMethodPageState();
}

class _AddProductPaymentMethodPageState
    extends State<AddProductPaymentMethodPage> with NavigatorHelper {
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
              Text(
                AppLocalizations.of(context)!.addPaymentMethod,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: darkBlue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.h),
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
                  onTap: () => jump(context, to: const ProductPaymentMethodPage()),
                  text: AppLocalizations.of(context)!.next,
                  buttonColor: greenColor),
            ],
          ),
        ),
      ),
    );
  }
}
