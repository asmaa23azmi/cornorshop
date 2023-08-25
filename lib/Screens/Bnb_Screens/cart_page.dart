import 'package:cornorshop/Fierbase/controllers/cart_fb_controller.dart';
import 'package:cornorshop/Helper/image_helper.dart';
import 'package:cornorshop/Models/fb/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';
import '../../Providers/auth_provider.dart';
import '../../Screens/Ordered_Screens/bill_details.dart';

import '../../Const/texts.dart';
import '../../Widgets/My_Widgets/my_button.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with NavigatorHelper, ImgHelper {
  List<CartModel> cartModel = [];

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

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
                _auth.loggedIn
                    ? StreamBuilder(
                        stream:
                            CartFbController().readFromCart(_auth.user!.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                                child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 80.h),
                              child: const CircularProgressIndicator(),
                            ));
                          } else if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            cartModel = snapshot.data!.docs
                                .map((e) => e.data())
                                .toList();
                            return Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: cartModel.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsetsDirectional.symmetric(
                                                      horizontal: 6.w,
                                                      vertical: 6.h),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(14.r),
                                                border: Border.all(
                                                    color: greyColor, width: 1.w),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ///Product Img
                                                  Container(
                                                    width: 90.w,
                                                    height: 90.w,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(14.r),
                                                      border: Border.all(
                                                          color:
                                                              blackObacityColor),
                                                    ),
                                                    child: appCacheImg(
                                                        cartModel[index]
                                                            .product
                                                            ?.img?[0]
                                                            .link,
                                                        const SizedBox()),
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      ///Product Nmae
                                                      Text(
                                                        '${cartModel[index].product?.name}',
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: darkBlue,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),

                                                      /// Store Name
                                                      Row(
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .store,
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: darkBlue,
                                                            ),
                                                          ),
                                                          SizedBox(width: 3.w),
                                                          Text(
                                                            '${cartModel[index].product?.userModel?.name}',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                              '${cartModel[index].product?.price} ₪',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: darkBlue,
                                                              ),
                                                            ),
                                                            const Spacer(),

                                                            ///Determine Quantity
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () =>
                                                                    setState(() => cartModel[index].product!.quantity++),
                                                                  highlightColor: Colors.transparent,
                                                                  splashColor: Colors.transparent,
                                                                  child:
                                                                      Container(
                                                                    height: 32.h,
                                                                    width: 32.h,
                                                                    padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color: greyColor,
                                                                          width: 0.3.w),
                                                                      borderRadius:
                                                                          BorderRadiusDirectional.circular(4.r),
                                                                    ),
                                                                    child: Center(
                                                                      child: Icon(Icons.add,
                                                                        color: darkBlue,
                                                                        size: 22.h,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 8.w),
                                                                Text(cartModel[index].product!.quantity.toString(),
                                                                  style:
                                                                      textStyle,
                                                                ),
                                                                SizedBox(width: 8.w),
                                                                InkWell(
                                                                  onTap: () {
                                                                  setState(() {
                                                                   if (cartModel[index].product!.quantity > 1) {
                                                                     cartModel[index].product?.quantity--;
                                                                    } else {
                                                                     null;
                                                                           }
                                                                      },
                                                                    );
                                                                  },
                                                                  highlightColor: Colors.transparent,
                                                                  splashColor: Colors.transparent,
                                                                  child: Container(
                                                                    height: 32.h,
                                                                    width: 32.h,
                                                                    padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: greyColor,
                                                                          width: 0.3.w),
                                                                      borderRadius: BorderRadiusDirectional.circular(4.r),
                                                                    ),
                                                                    child: Center(
                                                                      child: Icon(
                                                                        Icons.remove,
                                                                        color:blackObacityColor,
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
                                              end: 8.w,
                                              top: 8.h,
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async =>
                                                    CartFbController()
                                                        .deleteFromCart(
                                                            cartModel[index]),
                                                child:  Icon(
                                                  Icons.delete_rounded,
                                                  color: blackObacityColor,
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
                                  SizedBox(height: 25.h),
                                  ///check out
                                  Container(
                                    //height: 44.h,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsetsDirectional.symmetric(
                                            horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              14.r),
                                      border: Border.all(
                                          color: greyColor, width: 0.4.w),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .totalBasketPurchases,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .shipping,
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
                                  SizedBox(height: 12.h),
                                  MyButton(
                                    text: AppLocalizations.of(context)!
                                        .checkOut,
                                    onTap: () {
                                      jump(context,
                                          to: const BillDetailScreen());
                                    },
                                    buttonColor: greenColor,
                                  ),

                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 150.h),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.noProductInCart,
                                  style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.normal,
                                      color: blackObacityColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        },
                      )
                    : Center(
                        child: Text(
                          AppLocalizations.of(context)!.logInToShowCart,
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.normal,
                              color: blackObacityColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ],
            ),
          ),
        ));
  }

  num _getTotalPrice() {
    num totalPrice = 0;
    for (int index = 0; index < cartModel.length; index++) {
      num price =
          cartModel[index].product!.price! * cartModel[index].product!.quantity;
      totalPrice = totalPrice + price;
    }
    return totalPrice;
  }
}
