import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/product_model.dart';
import '../../Widgets/my_profile_settings.dart';
import '../Vendor_Screens/edit_vendor_profile_Page.dart';
import '../Vendor_Screens/product_screens/insert_product_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with NavigatorHelper {
  List<ProductModel> product = [
    ProductModel(
      productId: 1,
      productName: 'كيكة الكريمة',
      productPrice: 25.0,
      productImg: ['cake'],
      productCategoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: 2,
      productName: 'مسخن رول _ عدد 1 ',
      productPrice: 2.0,
      productImg: ['food'],
      productCategoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: 3,
      productName: 'قميص شتوي ',
      productPrice: 70.0,
      productImg: ['shirt'],
      productCategoryType: 'ملابس',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: 2,
      productName: 'مسخن رول _ عدد 1 ',
      productPrice: 2.0,
      productImg: ['food'],
      productCategoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: 3,
      productName: 'قميص شتوي ',
      productPrice: 70.0,
      productImg: ['shirt'],
      productCategoryType: 'ملابس',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),

  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    ///This value is use to determine the layout in GridView(childAspectRatio).
    final double itemHeight = (size.height - kToolbarHeight - 290) / 2;
    final double itemWidth = size.width / 2;

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
                            child: VendorTasks(
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
                            child: VendorTasks(
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
                            child: VendorTasks(
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
                    itemCount: product.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (itemWidth.w / itemHeight.h),
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1),
                    itemBuilder: (context, index) {
                      return Container(
                        //width: 110.h,
                        //height: 300.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF000000).withOpacity(0.15),
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Product Img
                              Container(
                                width: 125.w,
                                height: 90.h,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius:
                                  BorderRadiusDirectional.circular(4.r),
                                ),
                                child: Image.asset(
                                  'assets/images/${product[index].productImg[0]}.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),

                              ///Product Category
                              Container(
                                height: 15.h,
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 3.w),
                                decoration: BoxDecoration(
                                  color: orangeColor.withOpacity(0.3),
                                  borderRadius:
                                  BorderRadiusDirectional.circular(4.r),
                                ),
                                child: Text(
                                  product[index].productCategoryType,
                                  style: TextStyle(
                                    fontSize: 6.sp,
                                    color: orangeColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),

                              ///Product Name
                              Expanded(
                                child: Text(
                                  product[index].productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8.5.sp,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),

                              ///Vendor Name & Price
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 14.w,
                                      height: 14.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 12.h,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      product[index].vendorName,
                                      style: TextStyle(
                                        fontSize: 7.sp,
                                        fontWeight: FontWeight.normal,
                                        color: darkBlue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16.w,
                                    ),
                                    Text(
                                      '${product[index].productPrice} ₪',
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                            ],
                          ),
                        ),
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

/// Actions Profile
class VendorTasks extends StatelessWidget {
  late IconData? icon;
  late String text;
  late Function()? onTap;

  VendorTasks({
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
