import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Const/colors.dart';
import 'my_button.dart';

Widget myExitDialog(BuildContext context){
    return Dialog(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(14.r),
      ),
      child: Container(
        width: 234.w,
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Paragraph
            Text(
              AppLocalizations.of(context)!.closeApp,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: darkBlue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h
            ),

            ///yes
            MyButton(
              onTap: () async {
                SystemNavigator.pop();
                if (context.mounted) {}
              },
              text: AppLocalizations.of(context)!.yes,
              buttonColor: greenColor,
              myWidth: 135,
              myHeight: 38,
              myFontSize: 12,
            ),
            SizedBox(height: 16.h),

            ///no
            MyButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: AppLocalizations.of(context)!.no,
              buttonColor: Colors.transparent,
              myWidth: 135,
              myHeight: 38,
              myFontSize: 12,
              borderBouttonColor: greenColor,
              textButtonColor: greenColor,
            ),
          ],
        ),
      ),
    );
}