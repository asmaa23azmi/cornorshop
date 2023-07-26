import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Const/colors.dart';
import '../../../../Const/texts.dart';
import '../../../../Widgets/my_button.dart';
import '../../../../Helper/navigator_helper.dart';
import '../../../../Screens/Vendor_Screens/product_screens/Product_Promotion_Screens/add_product_payment_method.dart';

class ProductBudgetAndDurationPage extends StatefulWidget {
  const ProductBudgetAndDurationPage({super.key});

  @override
  State<ProductBudgetAndDurationPage> createState() =>
      _ProductBudgetAndDurationPageState();
}

class _ProductBudgetAndDurationPageState
    extends State<ProductBudgetAndDurationPage> with NavigatorHelper{
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
          AppLocalizations.of(context)!.promotionBudgetAndDuration,
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
                child: Text(
                  AppLocalizations.of(context)!.selectBudgetAndDuration,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: darkBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 6.h),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.promotionBudgetAndDurationParagraph,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: darkBlue,
                  ),
                ),
              ),
              const Spacer(),
              MyButton(
                  onTap: () => jump(context, to: const AddProductPaymentMethodPage()),
                  text: AppLocalizations.of(context)!.next,
                  buttonColor: greenColor),
            ],
          ),
        ),
      ),
    );
  }
}
