
import '../../Screens/Vendor_Screens/product_screens/vendor_product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Widgets/My_Widgets/my_profile_settings.dart';
import '../Vendor_Screens/edit_vendor_profile_Page.dart';
import '../Vendor_Screens/product_screens/insert_product_page.dart';
import '../../Helper/image_helper.dart';
import '../../Providers/auth_provider.dart';

class VendorProfilePage extends StatefulWidget {
  const VendorProfilePage({super.key});

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage>
    with NavigatorHelper, ImgHelper {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.4,
            backgroundColor: whiteColor,
            //toolbarHeight: 100.h,
            title: Text(
              AppLocalizations.of(context)!.userPage,
              style: textAppBarStyle,
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
                        horizontal: 14.w, vertical: 10.h),
                    width: double.infinity.w,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Profile Img
                        Container(
                          width: 80.w,
                          height: 80.w,
                          clipBehavior: Clip.antiAlias,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: appCacheImg(
                            auth.user?.profileImg?.link ?? '',
                            Icon(
                              Icons.person,
                              size: 60.h,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),

                        ///Vendor Name
                        Text(
                          auth.user?.name ?? '',
                          style: textStyle,
                        ),
                        SizedBox(height: 5.h),

                        ///Bio
                        Text(
                          auth.user?.description ?? '',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFF000000).withOpacity(0.55)),
                        ),
                        SizedBox(height: 16.h),

                        /// Vendor Tasks
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            ///Edit Profile
                            Expanded(
                              child: VendorTasks(
                                icon: Icons.edit,
                                text: AppLocalizations.of(context)!.editProfile,
                                onTap: () {
                                  jump(context, to: const EditVendorProfile());
                                },
                              ),
                            ),

                            ///Add Product
                            Expanded(
                              child: VendorTasks(
                                icon: Icons.add,
                                text: AppLocalizations.of(context)!.addProduct,
                                onTap: () {
                                  jump(context, to: const InsertProductPage());
                                },
                              ),
                            ),

                            ///Share Profile
                            Expanded(
                              child: VendorTasks(
                                icon: Icons.share_rounded,
                                text:
                                    AppLocalizations.of(context)!.shareProfile,
                                onTap: () {},
                              ),
                            ),

                            ///More
                            Expanded(
                              child: VendorTasks(
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
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 26.w,
                                                vertical: 10.h),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              420,
                                          child: Column(
                                            children: [
                                              ///Black Divider
                                              Container(
                                                height: 4,
                                                margin: EdgeInsetsDirectional
                                                    .symmetric(
                                                        horizontal:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                        vertical: MediaQuery.of(
                                                                    context)
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
                      ],
                    ),
                  ),

                  ///Vendor Product List
                 const VendorProductList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Actions Profile
class VendorTasks extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Function()? onTap;

  const VendorTasks({
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
            color: greenColor,
            size: 24.h,
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 9.sp,
              color: greenColor,
            ),
          )
        ],
      ),
    );
  }
}
