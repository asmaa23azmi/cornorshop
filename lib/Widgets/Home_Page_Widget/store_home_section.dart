import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';
import '../my_button.dart';
import '../../Screens/Buyer_Screens/view_vendor_profile.dart';

class StoreHomeSection extends StatefulWidget {
  const StoreHomeSection({super.key});

  @override
  State<StoreHomeSection> createState() => _StoreHomeSectionState();
}

class _StoreHomeSectionState extends State<StoreHomeSection> with NavigatorHelper{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 106.h,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsetsDirectional.only(start: 14.w),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => jump(context, to: const ViewVendorProfile()),
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: greyColor),
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
                    onTap: () => jump(context, to: const ViewVendorProfile()),
                    text: AppLocalizations.of(context)!.openPage,
                    myWidth: 70,
                    myHeight: 26,
                    myFontSize: 8,
                    textButtonColor: whiteColor,
                    buttonColor: greenColor,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width:6.w),
      ),
    );
  }
}
