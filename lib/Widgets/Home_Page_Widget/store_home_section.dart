import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../my_button.dart';

class StoreHomeSection extends StatefulWidget {
  const StoreHomeSection({super.key});

  @override
  State<StoreHomeSection> createState() => _StoreHomeSectionState();
}

class _StoreHomeSectionState extends State<StoreHomeSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 106.h,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsetsDirectional.only(start: 20.w),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 10.w, vertical: 10.h),
            // width: 150.w,
            // height: 80.h,
            decoration: BoxDecoration(
              border: Border.all(color: blackObacityColor, width: 1.w),
              borderRadius: BorderRadiusDirectional.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 18.h,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      'اسم البائعة',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 9.0.sp,
                        color: darkBlue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  'نص يحتوي على وصف قام البائع باضافته',
                  style: TextStyle(
                      fontSize: 8.0.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF000000).withOpacity(0.55)),
                ),
                // SizedBox(height: 3.h),
                const Spacer(),
                MyButton(
                  onTap: () {},
                  text: AppLocalizations.of(context)!.openPage,
                  myWidth: 55,
                  myHeight: 20,
                  myFontSize: 6.5,
                  textButtonColor: whiteColor,
                  buttonColor: orangeColor,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 4.w),
      ),
    );
  }
}
