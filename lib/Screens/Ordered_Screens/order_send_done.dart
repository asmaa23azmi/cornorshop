import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';

class OrderedSendScreen extends StatefulWidget {
  const OrderedSendScreen({super.key});

  @override
  State<OrderedSendScreen> createState() => _OrderedSendScreenState();
}

class _OrderedSendScreenState extends State<OrderedSendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: babyBlue,
        toolbarHeight: 124.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(20.r),
              bottomStart: Radius.circular(20.r)),
        ),
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 24.0.h,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.orderCompleted,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: 20.w, vertical: 100.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/happy.png',
                height: 160.h,
                width: 160.h,
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                AppLocalizations.of(context)!.paragraphOrder,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: darkBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
