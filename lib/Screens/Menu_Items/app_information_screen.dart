import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';


class AppInformation extends StatefulWidget {
  const AppInformation({super.key});

  @override
  State<AppInformation> createState() => _AppInformationState();
}

class _AppInformationState extends State<AppInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0.0,
      backgroundColor: babyBlue,
        toolbarHeight: 124.h,
        title: Text(AppLocalizations.of(context)!.appInfo,style: textAppBarStyle,),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              bottomEnd:Radius.circular(20.r),
              bottomStart: Radius.circular(20.r)),
        ),
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){ Navigator.pop(context);},
          child: Icon(Icons.arrow_back_ios,
            color: darkBlue,
            size: 24.0.h,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w , vertical: 30.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.appServices, style: TextStyle(
                fontSize: 14.sp, color: orangeColor),),
              SizedBox(height: 14.h,),
              ///Stores
              _infoItems(AppLocalizations.of(context)!.stores , Icons.store_mall_directory_rounded),
              SizedBox(height: 6.h,),
              Text(AppLocalizations.of(context)!.storesDescription, style: TextStyle(
                  fontSize: 14.sp , color: darkBlue),),
              SizedBox(height: 10.h,),
              Divider(color: grayColor, height: 0.3.h,),
              SizedBox(height: 15.h,),
              ///sale
              _infoItems(AppLocalizations.of(context)!.sale , Icons.point_of_sale),
              SizedBox(height: 6.h,),
              Text(AppLocalizations.of(context)!.saleDescription, style: TextStyle(
                  fontSize: 14.sp , color: darkBlue),),
              SizedBox(height: 10.h,),
              Divider(color: grayColor, height: 0.3.h,),
              SizedBox(height: 15.h,),
              ///delivery
              _infoItems(AppLocalizations.of(context)!.delivery, Icons.delivery_dining_rounded),
              SizedBox(height: 6.h,),
              Text(AppLocalizations.of(context)!.deliveryDescription, style: TextStyle(
                  fontSize: 14.sp , color: darkBlue),),
              SizedBox(height: 10.h,),
              Divider(color: grayColor, height: 0.3.h,),
              SizedBox(height: 15.h,),
              ///payment
              _infoItems(AppLocalizations.of(context)!.payment, Icons.payment_rounded),
              SizedBox(height: 6.h,),
              Text(AppLocalizations.of(context)!.paymentDescription, style: TextStyle(
                  fontSize: 14.sp , color: darkBlue),),
              SizedBox(height: 10.h,),
              Divider(color: grayColor, height: 0.3.h,),
              SizedBox(height: 15.h,),
            ],
          ),
        ),
      ),
    );
  }
  Widget _infoItems( String text , IconData icon){
    return  Row(
      children: [
        Icon(icon, size: 23.w, color: orangeColor,),
        SizedBox(width: 10.w,),
        Text(text, style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: orangeColor,
        ),),
      ],
    );
  }
}
