import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';
import '../../Models/product_model.dart';
import '../../Screens/Ordered_Screens/bill_details.dart';

import '../../Const/texts.dart';
import '../../Widgets/my_button.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with NavigatorHelper {
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
  ];

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
              AppLocalizations.of(context)!.cartBar,
              style: textAppBarStyle,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.shoppingTrolley,
                  style: bnbTitlestyle,
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///Product List
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return Row(
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
                              border: Border.all(color: blackObacityColor),
                            ),
                            child: Image.asset(
                              'assets/images/${product[index].productImg[0]}.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
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
                              SizedBox(
                                height: 4.h,
                              ),

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
                              SizedBox(
                                height: 4.h,
                              ),

                              /// Product Price
                              Text(
                                '${product[index].productPrice} ₪',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: darkBlue,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                          ///Product Quantity
                          Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.quantity,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: darkBlue,
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 4.w),
                                width: 90.w,
                                height: 34.h,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(14.0.r),
                                  border: Border.all(
                                    color: blackObacityColor,
                                    width: 1.w,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(
                                          () {
                                            product[index].productQuantity++;
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: blackObacityColor,
                                        size: 22.h,
                                      ),
                                    ),
                                    Text(
                                      product[index].productQuantity.toString(),
                                      style: textStyle,
                                    ),
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        setState(
                                          () {
                                            if (product[index].productQuantity >
                                                1) {
                                              product[index].productQuantity--;
                                            } else {
                                              null;
                                            }
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: blackObacityColor,
                                        size: 22.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {},
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 90.w,
                                  height: 34.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(
                                            14.0.r),
                                    border: Border.all(
                                      color: blackObacityColor,
                                      width: 1.w,
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.remove,
                                    style: TextStyle(
                                      fontSize: 13.0.sp,
                                      fontWeight: FontWeight.normal,
                                      color: blackObacityColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Divider(
                            color: greyColor,
                            height: 0.3.h,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 20.w, vertical: 20.h),
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(14.r),
                    border: Border.all(color: blackObacityColor, width: 1.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Title
                      Text(
                        AppLocalizations.of(context)!.totalBasketPurchases,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: darkBlue,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),

                      ///Details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.total,
                            style: textStyle,
                          ),
                          Text(
                            '${_getTotalPrice()} ₪',
                            style: textStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Divider(
                        color: greyColor,
                        height: 0.3.h,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.shipping,
                            style: textStyle,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.fixedPrice} 5.0 ₪',
                            style: textStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      ///Action
                      MyButton(
                        text: AppLocalizations.of(context)!.addToCart,
                        onTap: () {
                          jump(context, to: const BillDetailScreen());
                        },
                        buttonColor: orangeColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
