import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/category_model.dart';
import '../../Models/product_model.dart';
import '../../Widgets/Home_Page_Widget/category_home_section.dart';
import '../../Widgets/Home_Page_Widget/product_list_home_section.dart';
import '../../Widgets/Home_Page_Widget/recommend_product_home_section.dart';
import '../../Widgets/Home_Page_Widget/store_home_section.dart';
import '../../Widgets/My_Widgets/my_list_item.dart';
import '../Menu_Items_screens/app_information_page.dart';
import '../Menu_Items_screens/app_settings_page.dart';
import '../Menu_Items_screens/message_page.dart';
import '../Menu_Items_screens/notifications_page.dart';
import '../Search_Screens/search_page.dart';
import '../../Const/texts.dart';
import '../../Screens/Bnb_Screens/category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigatorHelper {
  int selectedIndex = 0;
  List<CategoryModel> categoryItems = [
    CategoryModel(
      categoryId: '1',
      categoryImg: 'clothIcon',
      //categoryTitle: appLocale.cloth,
      categoryTitle: 'ملابس',
    ),
    CategoryModel(
      categoryId: '2',
      categoryImg: 'naturalProductIcon',
      //categoryTitle: AppLocalizations.of(context)!.naturalProduct,
      categoryTitle: 'منتجات طبيعية',
    ),
    CategoryModel(
      categoryId: '3',
      categoryImg: 'homeFoodIcon',
      // categoryTitle: AppLocalizations.of(context)!.homeFood,
      categoryTitle: 'طعام وحلويات منزلية',
    ),
    CategoryModel(
      categoryId: '4',
      categoryImg: 'handicraftsIcon',
      // categoryTitle: AppLocalizations.of(context)!.handicrafts,
      categoryTitle: 'مشغولات يدوية',
    ),
  ];
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        toolbarHeight: 66.h,
        title: Padding(
          padding: EdgeInsetsDirectional.only(
            //start: 15.w,
            top: 15.h,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Image.asset(
              'assets/images/shopLogo.png',
              width: 110.w,
              height: 34.h,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: 15.w,
              top: 15.h,
            ),
            child: Row(
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    jump(context, to: const SearchPage());
                  },
                  child: Icon(
                    Icons.search,
                    color: darkBlue,
                    size: 30.h,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,

                  ///call_back
                  onTap: () {
                    ///Bottom Sheet
                    _appSettingsBottomSheet(context);
                  },
                  child: Icon(
                    Icons.menu_rounded,
                    color: darkBlue,
                    size: 32.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 0.w, vertical: 10.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Ads
              Stack(
                children: [
                  SizedBox(
                    height: 150.h,
                    child: PageView.builder(
                      onPageChanged: (value) =>
                          setState(() => selectedIndex = value),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadiusDirectional.circular(14.r)),
                        );
                      },
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 10.h,
                    start: 0,
                    end: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 10.h,
                      child: ListView.separated(
                        padding: EdgeInsetsDirectional.zero,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          bool selected = selectedIndex == index;
                          return Container(
                            height: 10.h,
                            width: 10.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selected
                                  ? blackObacityColor
                                  : Colors.transparent,
                              border: Border.all(
                                  color: selected
                                      ? Colors.transparent
                                      : blackObacityColor),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 4.w),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              ///Category Section
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.categoryBar,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: darkBlue,
                          fontSize: 14.sp),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        jump(context, to: const CategoryPage());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.showAll,
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              CategoryHomeSection(categoryItems: categoryItems),
              SizedBox(height: 8.h),

              ///Stores Section
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
              const StoreHomeSection(),
              SizedBox(height: 15.h),

              ///Recommend Products
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                child: Text(
                  AppLocalizations.of(context)!.recommendProducts,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: darkBlue,
                      fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 6.h),
              RecommendProductHomeSection(product: product),
              SizedBox(height: 15.h),

              ///Products List
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                child: Text(
                  AppLocalizations.of(context)!.productsList,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: darkBlue,
                      fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 6.h),
              const ProductListHomeSection(),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _appSettingsBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(20.r), topEnd: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 26.w, vertical: 10.h),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                ///Black Divider
                Container(
                  height: 4,
                  margin: EdgeInsetsDirectional.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.4,
                      vertical: MediaQuery.of(context).size.height * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadiusDirectional.circular(2.r),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                ///Notification
                MyListItem(
                  text: AppLocalizations.of(context)!.notifications,
                  icon: Icons.notifications,
                  size: 21.w,
                  onTap: () {
                    jump(context, to: const NotificationPage());
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(
                  height: 18.h,
                ),

                ///Message
                MyListItem(
                  text: AppLocalizations.of(context)!.msg,
                  icon: Icons.message,
                  size: 21.w,
                  onTap: () {
                    jump(context, to: const MessagePage());
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(
                  height: 18.h,
                ),

                ///App Settings
                MyListItem(
                  text: AppLocalizations.of(context)!.appSettings,
                  icon: Icons.settings,
                  size: 21.w,
                  onTap: () {
                    jump(context, to: const AppSettingPge());
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(
                  height: 18.h,
                ),

                ///App Information
                MyListItem(
                  text: AppLocalizations.of(context)!.appInfo,
                  icon: Icons.info_outline_rounded,
                  size: 21.w,
                  onTap: () {
                    jump(
                      context,
                      to: const AppInformation(),
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(
                  height: 18.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
