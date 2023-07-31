import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Const/colors.dart';
import '../../../../Const/texts.dart';
import '../../../../Widgets/My_Widgets/my_button.dart';
import '../../../../Helper/navigator_helper.dart';
import '../../../../Screens/Vendor_Screens/product_screens/Product_Promotion_Screens/product_budget_and_duration.dart';

class ProductPromotionTargetPage extends StatefulWidget {
  const ProductPromotionTargetPage({super.key});

  @override
  State<ProductPromotionTargetPage> createState() =>
      _ProductPromotionTargetPageState();
}

class _ProductPromotionTargetPageState
    extends State<ProductPromotionTargetPage> with NavigatorHelper {
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
          AppLocalizations.of(context)!.productPromotionGoal,
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
                  AppLocalizations.of(context)!.selectAPromotionGoal,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: darkBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 6.h),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.promotionGoalParagraph,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: darkBlue,
                  ),
                ),
              ),
              const Spacer(),
              MyButton(
                  onTap: () => jump(context, to: const ProductBudgetAndDurationPage()),
                  text: AppLocalizations.of(context)!.next,
                  buttonColor: greenColor),
            ],
          ),
        ),
      ),
    );
  }
}
