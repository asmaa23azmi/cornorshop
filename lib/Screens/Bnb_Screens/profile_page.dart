import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Widgets/my_profile_settings.dart';
import '../Vendor_Screens/edit_vendor_profile_Page.dart';
import '../Vendor_Screens/product_screens/insert_product_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with NavigatorHelper {
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
            AppLocalizations.of(context)!.userPage,
            style: textAppBarStyle,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20.w, vertical: 20.h),
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Profile Img
                    Container(
                      width: 80.w,
                      height: 80.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60.h,
                        color: Colors.grey.shade300,
                      ),
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
                    SizedBox(
                      height: 16.h,
                    ),

                    /// Vendor Tasks
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          ///Edit Profile
                          Expanded(
                            child: vndor_tasks(
                              icon: Icons.edit,
                              text: AppLocalizations.of(context)!.editProfile,
                              onTap: () {
                                jump(context, to: const EditVendorProfile());
                              },
                            ),
                          ),
                          VerticalDivider(
                            width: 20.w,
                            thickness: 0.3.w,
                            indent: 0,
                            endIndent: 20,
                            color: greyColor,
                          ),

                          ///Add Product
                          Expanded(
                            child: vndor_tasks(
                              icon: Icons.add,
                              text: AppLocalizations.of(context)!.addProduct,
                              onTap: () {
                                jump(context, to: const InsertProductPage());
                              },
                            ),
                          ),
                          VerticalDivider(
                            width: 20.w,
                            thickness: 0.3.w,
                            indent: 0,
                            endIndent: 20,
                            color: greyColor,
                          ),

                          ///Share Profile
                          Expanded(
                            child: vndor_tasks(
                              icon: Icons.share_rounded,
                              text: AppLocalizations.of(context)!.shareProfile,
                              onTap: () {},
                            ),
                          ),
                          VerticalDivider(
                            width: 20.w,
                            thickness: 0.3.w,
                            indent: 0,
                            endIndent: 20,
                            color: greyColor,
                          ),

                          ///More
                          Expanded(
                            child: vndor_tasks(
                              icon: Icons.more_horiz,
                              text: AppLocalizations.of(context)!.more,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                              topStart: Radius.circular(20.r),
                                              topEnd: Radius.circular(20.r))),
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 26.w, vertical: 10.h),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                420,
                                        child: Column(
                                          children: [
                                            ///Black Divider
                                            Container(
                                              height: 4,
                                              margin: EdgeInsetsDirectional
                                                  .symmetric(
                                                      horizontal:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      vertical:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(2.r),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsetsDirectional.zero,
                    shrinkWrap: true,
                    itemCount: 50,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsetsDirectional.only(
                          start: 6.w,
                          end: 6.w,
                          bottom: 6.h,
                        ),
                        width: 105.w,
                        height: 156.h,
                        color: Colors.grey.shade200,
                        // changes position of shadow
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              fontSize: 9.sp,
              color: orangeColor,
            ),
          )
        ],
      ),
    );
  }
}
