import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/my_button.dart';
import '../../Widgets/my_profile_settings.dart';
import 'edit_vendor_profile_Page.dart';
import '../../Screens/Vendor_Screens/product_screens/insert_product_page.dart';
import '../../Helper/navigator_helper.dart';

class VendorProfilePage extends StatefulWidget {
  const VendorProfilePage({super.key});

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage>
    with NavigatorHelper {
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
            ///Profile Img
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: greyColor,
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
            ///Vendor Name
            Text(
              'اسم البائع/ المتجر',
              style: textStyle,
            ),
            SizedBox(
              height: 5.h,
            ),
            ///Bio
            Text(
              'وصف يقوم البائع بإضافته يحتوي على بعض معلوماته الشخصية الضرورية, ومعلومات حول المنتجات التي يقدمها',
              style: TextStyle(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF000000).withOpacity(0.55)),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ///Edite Profile
            //     MyButton(
            //       onTap: () {
            //         jump(context, to: const EditVendorProfile());
            //       },
            //       text: AppLocalizations.of(context)!.editProfile,
            //       buttonColor: orangeColor,
            //       myWidth: 100.w,
            //       myHeight: 34.h,
            //       myFontSize: 8.sp,
            //     ),
            //
            //     ///Add Product
            //     MyButton(
            //       onTap: () {
            //         jump(context, to: const InsertProductPage());
            //       },
            //       text: AppLocalizations.of(context)!.addProduct,
            //       buttonColor: orangeColor,
            //       myWidth: 100.w,
            //       myHeight: 34.h,
            //       myFontSize: 8.sp,
            //     ),
            //
            //     ///Share Profile
            //     MyButton(
            //       onTap: () {},
            //       text: AppLocalizations.of(context)!.shareProfile,
            //       buttonColor: orangeColor,
            //       myWidth: 100.w,
            //       myHeight: 34.h,
            //       myFontSize: 8.sp,
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 14.h,
            ),
            /// Vendor Tasks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisSize: MainAxisSize.min,
              children: [
                ///Edit Profile
                vndor_tasks(
                  icon: Icons.edit,
                  text: AppLocalizations.of(context)!.editProfile,
                  onTap: () {
                    jump(context, to: const EditVendorProfile());
                  },
                ),
                ///Add Product
                vndor_tasks(
                  icon: Icons.add,
                  text: AppLocalizations.of(context)!.addProduct,
                  onTap: () {
                    jump(context, to: const InsertProductPage());
                  },
                ),
                ///Share Profile
                vndor_tasks(
                  icon: Icons.share_rounded,
                  text: AppLocalizations.of(context)!.shareProfile,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class vndor_tasks extends StatelessWidget {
  late IconData? icon;
  late String text;
  late Function()? onTap;

  vndor_tasks({
    required this.text,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 10.h),
        width: 100.w,
        height: 90.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(14.r),
          color: Colors.grey.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: orangeColor,
              size: 24.h,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 10.sp,
                color: orangeColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
