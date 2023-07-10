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

class _OrderedSendScreenState extends State<OrderedSendScreen>  {
  late AppLocalizations appLocale = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
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
        title: Text(appLocale.orderCompleted, style: textAppBarStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/happy.png', height: 160.h, width: 160.h,),
              SizedBox(height: 40.h,),
              Text(appLocale.paragraph, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: darkBlue,
              ),),
            ],
          ),
        ),
      ),

    );
  }
}
