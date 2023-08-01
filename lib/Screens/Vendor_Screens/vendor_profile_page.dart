import 'package:cornorshop/Screens/Vendor_Screens/product_screens/product_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/fb/product_model.dart';
import '../../Widgets/My_Widgets/my_profile_settings.dart';
import '../Vendor_Screens/edit_vendor_profile_Page.dart';
import '../Vendor_Screens/product_screens/insert_product_page.dart';

class VendorProfilePage extends StatefulWidget {
  const VendorProfilePage({super.key});

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage>
    with NavigatorHelper {
  List<ProductModel> product = [
    ProductModel(
      productId: '1',
      productName: 'كيكة الكريمة',
      productPrice: 25.0,
      productImg: ['cake'],
      productCategoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: '2',
      productName: 'مسخن رول _ عدد 1 ',
      productPrice: 2.0,
      productImg: ['food'],
      productCategoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: '3',
      productName: 'قميص شتوي ',
      productPrice: 70.0,
      productImg: ['shirt'],
      productCategoryType: 'ملابس',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: '2',
      productName: 'مسخن رول _ عدد 1 ',
      productPrice: 2.0,
      productImg: ['food'],
      productCategoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: '3',
      productName: 'قميص شتوي ',
      productPrice: 70.0,
      productImg: ['shirt'],
      productCategoryType: 'ملابس',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: '2',
      productName: 'مسخن رول _ عدد 1 ',
      productPrice: 2.0,
      productImg: ['food'],
      productCategoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      productQuantity: 1,
    ),
    ProductModel(
      productId: '3',
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
    return Scaffold(
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
                    SizedBox(height: 3.h),

                    ///Vendor Name
                    Text(
                      'اسم البائع/ المتجر',
                      style: textStyle,
                    ),
                    SizedBox(height: 5.h),

                    ///Bio
                    Text(
                      'وصف يقوم البائع بإضافته يحتوي على بعض معلوماته الشخصية الضرورية, ومعلومات حول المنتجات التي يقدمها',
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF000000).withOpacity(0.55)),
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
                            text: AppLocalizations.of(context)!.shareProfile,
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
                  ],
                ),
              ),
              ///Vendor Product List
              Column(
                children: [
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                    shrinkWrap: true,
                    itemCount: product.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //This value is use to determine the layout in GridView(childAspectRatio).
                      childAspectRatio: 110.w / 160.h,
                      crossAxisCount: 3,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => jump(context, to:const ProductViewPage()),
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(4.r),
                            border: Border.all(width: 1.w, color: greyColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Product Img
                              Expanded(
                                child: Container(
                                  // width: 105.w,
                                  width: double.infinity,
                                  // height: 90.h,
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
                              ),
                              SizedBox(height: 5.h),

                              ///Product Category
                              Container(
                                height: 16.h,
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 3.w),
                                decoration: BoxDecoration(
                                  color: greenColor.withOpacity(0.3),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(4.r),
                                ),
                                child: Text(
                                  product[index].productCategoryType,
                                  style: TextStyle(
                                    fontSize: 6.5.sp,
                                    color: greenColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),

                              ///Product Name
                              Text(
                                product[index].productName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9.sp,
                                  color: darkBlue,
                                  height: 1.h,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.h),

                              ///Vendor Name & Price
                              Row(
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
                                  SizedBox(width: 2.w),
                                  Text(
                                    product[index].vendorName,
                                    style: TextStyle(
                                      fontSize: 7.5.sp,
                                      fontWeight: FontWeight.normal,
                                      color: darkBlue,
                                      height: 1.h,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${product[index].productPrice} ₪',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue,
                                      height: 1.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
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
