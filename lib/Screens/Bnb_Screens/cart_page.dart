import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';
import '../../Models/fb/product_model.dart';
import '../../Screens/Ordered_Screens/bill_details.dart';

import '../../Const/texts.dart';
import '../../Widgets/My_Widgets/my_button.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: whiteColor,
          //toolbarHeight: 100.h,
          title: Text(
            AppLocalizations.of(context)!.cartBar,
            style: textAppBarStyle,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 14.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.shoppingTrolley,
                  style: bnbTitlestyle,
                ),
                SizedBox(height: 10.h),

                ///Product List
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 6.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(14.r),
                              border: Border.all(color: greyColor, width: 1.w),
                            ),
                            child: Row(
                              children: [
                                ///Product Img
                                Container(
                                  width: 90.w,
                                  height: 90.w,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(14.r),
                                    border:
                                        Border.all(color: blackObacityColor),
                                  ),
                                  child: Image.asset(
                                    'assets/images/${product[index].productImg[0]}.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Product Nmae
                                    Text(
                                      product[index].productName,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: darkBlue,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),

                                    /// Store Name
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.store,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: darkBlue,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                          product[index].vendorName,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.normal,
                                            color: darkBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    SizedBox(
                                      width: 230.w,
                                      child: Row(
                                        children: [
                                          /// Product Price
                                          Text(
                                            '${product[index].productPrice} ₪',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: darkBlue,
                                            ),
                                          ),
                                          const Spacer(),

                                          ///Determine Quantity
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      product[index]
                                                          .productQuantity++;
                                                    },
                                                  );
                                                },
                                                highlightColor:
                                                    Colors.transparent,
                                                splashColor: Colors.transparent,
                                                child: Container(
                                                  height: 32.h,
                                                  width: 32.h,
                                                  padding: EdgeInsetsDirectional
                                                      .symmetric(
                                                          horizontal: 4.w),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: greyColor,
                                                        width: 0.3.w),
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(4.r),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: darkBlue,
                                                      size: 22.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                product[index]
                                                    .productQuantity
                                                    .toString(),
                                                style: textStyle,
                                              ),
                                              SizedBox(width: 8.w),
                                              InkWell(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      if (product[index]
                                                              .productQuantity >
                                                          1) {
                                                        product[index]
                                                            .productQuantity--;
                                                      } else {
                                                        null;
                                                      }
                                                    },
                                                  );
                                                },
                                                highlightColor:
                                                    Colors.transparent,
                                                splashColor: Colors.transparent,
                                                child: Container(
                                                  height: 32.h,
                                                  width: 32.h,
                                                  padding: EdgeInsetsDirectional
                                                      .symmetric(
                                                          horizontal: 4.w),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: greyColor,
                                                        width: 0.3.w),
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(4.r),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: blackObacityColor,
                                                      size: 22.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          ///Delete product from cart
                          PositionedDirectional(
                            end: 6.w,
                            top: 8.h,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child:const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                               // size: 26.h,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                  ),
                ),
                ///check out
                Container(
                  //height: 44.h,
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(14.r),
                    border: Border.all(color: greyColor, width: 0.4.w),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalBasketPurchases,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: greenColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_getTotalPrice()} ₪',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: greenColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.shipping,
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              color: greenColor,
                            ),
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.fixedPrice} 5.0 ₪',
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              color: greenColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                MyButton(
                  text: AppLocalizations.of(context)!.addToCart,
                  onTap: () {
                    jump(context, to: const BillDetailScreen());
                  },
                  buttonColor: greenColor,
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ));
  }

  num _getTotalPrice() {
    num totalPrice = 0;
    for (int index = 0; index < product.length; index++) {
      num price = product[index].productPrice * product[index].productQuantity;
      totalPrice = totalPrice + price;
    }
    return totalPrice;
  }
}
