import 'package:cornorshop/Screens/Vendor_Screens/edit_vendor_profile_Page.dart';
import 'package:cornorshop/Widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widgets/my_profile_settings.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Screens/Vendor_Screens/product_screens/insert_product_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: grayColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(20.r),
                              topEnd: Radius.circular(20.r))),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 26.w, vertical: 10.h),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 420,
                            child: Column(
                              children: [
                                ///Black Divider
                                Container(
                                  height: 4,
                                  margin: EdgeInsetsDirectional.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.4,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.015),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(2.r),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                const MyProfileSettings(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: darkBlue,
                    size: 20.w,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              'اسم البائع/ المتجر',
              style: textStyle,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'وصف يقوم البائع بإضافته يحتوي على بعض معلوماته الشخصية الضرورية, ومعلومات حول المنتجات التي يقدمها',
              style: TextStyle(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF000000).withOpacity(0.55)),
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Edite Profile
                MyButton(
                  onTap: () {
                    jump(context, to: const EditVendorProfile());
                  },
                  text: AppLocalizations.of(context)!.editProfile,
                  buttonColor: orangeColor,
                  myWidth: 100.w,
                  myHeight: 34.h,
                  myFontSize: 8.sp,
                ),

                ///Add Product
                MyButton(
                  onTap: () {
                    jump(context, to: const InsertProductPage());
                  },
                  text: AppLocalizations.of(context)!.addProduct,
                  buttonColor: orangeColor,
                  myWidth: 100.w,
                  myHeight: 34.h,
                  myFontSize: 8.sp,
                ),

                ///Share Profile
                MyButton(
                  onTap: () {},
                  text: AppLocalizations.of(context)!.shareProfile,
                  buttonColor: orangeColor,
                  myWidth: 100.w,
                  myHeight: 34.h,
                  myFontSize: 8.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
