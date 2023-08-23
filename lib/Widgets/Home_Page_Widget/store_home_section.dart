import 'package:cornorshop/Fierbase/controllers/user_fb_controller.dart';
import 'package:cornorshop/Models/fb/user_model.dart';

import '../../Helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';
import '../My_Widgets/my_button.dart';
import '../../Screens/Buyer_Screens/view_vendor_profile.dart';

class StoreHomeSection extends StatefulWidget {
  const StoreHomeSection({super.key});

  @override
  State<StoreHomeSection> createState() => _StoreHomeSectionState();
}

class _StoreHomeSectionState extends State<StoreHomeSection> with NavigatorHelper, ImgHelper{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          child: Text(
            AppLocalizations.of(context)!.chosenStore,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: darkBlue,
                fontSize: 14.sp),
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          height: 106.h,
          child: StreamBuilder(
            stream: UserFbController().showVendor(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const SizedBox();
              }else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
                List<UserModel> vendors = snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsetsDirectional.only(start: 14.w , end: 14.w),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => jump(context, to:  ViewVendorProfile(user: vendors[index])),
                      child: Container(
                        width: 160.w,
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
                                ///Profile Img
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  child: appCacheImg('${vendors[index].profileImg?.link}',
                                      Icon(
                                        Icons.person,
                                        size: 18.h,
                                        color: Colors.grey.shade300,
                                      )),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  vendors[index].name ?? '',
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
                             vendors[index].description ?? '',
                              style: TextStyle(
                                  fontSize: 8.0.sp,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF000000).withOpacity(0.55)),
                            ),
                            // SizedBox(height: 3.h),
                            const Spacer(),
                            MyButton(
                              onTap: () => jump(context, to:  ViewVendorProfile(user: vendors[index])),
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
                );
              }else{
                return const SizedBox();
              }
            },
          )
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
