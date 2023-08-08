import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Models/fb/product_model.dart';
import '../../Widgets/My_Widgets/my_button.dart';

class CategoryItemScreen extends StatefulWidget {
  const CategoryItemScreen({super.key});

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  List<ProductModel> product = [
    ProductModel(
      id: '1',
      name: 'كيكة الكريمة',
      price: 25.0,
      img: ['cake'],
      categoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        // toolbarHeight: 70.h,

        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 22.h,
          ),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.homeFood,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 14.h),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            shrinkWrap: true,
            itemCount: product.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity.w,
                //height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(14.r),
                  border: Border.all(width: 1.w, color: greyColor),
                ),
                child: Row(
                  children: [
                    ///Product Img
                    Container(
                      margin: EdgeInsetsDirectional.symmetric(
                          horizontal: 6.w, vertical: 6.h),
                      width: 105.w,
                      height: 105.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(4.r),
                        color: Colors.grey.shade200,
                      ),
                      child: Image.asset(
                        'assets/images/${product[index].img![0]}.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),

                    ///Product Details
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Product Name
                          Text(
                            '${product[index].name}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: darkBlue,
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            children: [
                              /// Vendor or Store Name
                              Text(
                                '${product[index].vendorName}',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.normal,
                                  color: darkBlue,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),

                              /// Price
                              Text(
                                '${product[index].price} ₪',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: darkBlue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14.h,
                          ),

                          ///Action
                          Row(
                            children: [
                              MyButton(
                                text: AppLocalizations.of(context)!.addToCart,
                                myFontSize: 7,
                                myHeight: 25,
                                myWidth: 93,
                                buttonColor: greenColor,
                                borderBouttonColor: Colors.transparent,
                                onTap: () {},
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Icon(
                                  Icons.favorite_border_outlined,
                                  color: darkBlue,
                                  size: 24.w,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 15.h,
            ),
          ),
        ),
      ),
    );
  }
}
