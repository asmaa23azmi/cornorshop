import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';
import '../../Screens/Ordered_Screens/bill_details.dart';

import '../../Const/texts.dart';
import '../../Widgets/my_button.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: whiteColor,
          //toolbarHeight: 100.h,
          title: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
            child: Text(
              AppLocalizations.of(context)!.cartBar,
              style: textAppBarStyle,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
      padding:
            EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   AppLocalizations.of(context)!.cartBar,
            //   style: bnbTitlestyle,
            // ),
            SizedBox(
              height: 18.h,
            ),
            MyButton(
              text: AppLocalizations.of(context)!.addToCart,
              onTap: () {
                jump(context, to: BillDetailScreen());
              },
            ),
          ],
      ),
    ),
        ));
  }
}
