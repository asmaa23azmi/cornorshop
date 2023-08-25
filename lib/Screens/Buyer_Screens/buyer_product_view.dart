import 'package:cornorshop/Fierbase/controllers/cart_fb_controller.dart';
import 'package:cornorshop/Models/fb/cart_model.dart';
import 'package:cornorshop/enums.dart';
import 'package:uuid/uuid.dart';

import '../../../Fierbase/controllers/product_fb_controller.dart';
import '../../../Helper/image_helper.dart';
import '../../../Helper/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../Models/fb/product_model.dart';
import '../../Providers/auth_provider.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../../Helper/navigator_helper.dart';

class BuyerProductViewPage extends StatefulWidget {
  final ProductModel product;

  const BuyerProductViewPage({required this.product, super.key});

  @override
  State<BuyerProductViewPage> createState() => _BuyerProductViewPageState();
}

class _BuyerProductViewPageState extends State<BuyerProductViewPage>
    with NavigatorHelper, ImgHelper, SnackBarHelper {
  int selectedIndex = 0;

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
          AppLocalizations.of(context)!.productSpecifications,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 14.w, vertical: 10.h),
            // physics: const BouncingScrollPhysics(),
            child: StreamBuilder(
              stream: ProductFbController().readProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  ProductModel product = widget.product;
                  return Column(
                    //mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ///Product Img
                            SizedBox(
                              height: 245.h,
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    onPageChanged: (value) =>
                                        setState(() => selectedIndex = value),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: product.img?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsetsDirectional.symmetric(
                                            horizontal: 10.w),
                                        width: double.infinity,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  14.r),
                                        ),
                                        child: appCacheImg(
                                            product.img?[index].link,
                                            const SizedBox()),
                                      );
                                    },
                                  ),

                                  ///Scrolling Horizontal
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
                                        itemCount: product.img!.length,
                                        itemBuilder: (context, index) {
                                          bool selected =
                                              selectedIndex == index;
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

                                  ///Add To Fav. Action
                                  PositionedDirectional(
                                    end: 20.w,
                                    top: 10.h,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {},
                                      child: Container(
                                        height: 38.h,
                                        width: 38.h,
                                        decoration: const BoxDecoration(
                                            color: whiteColor,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite_border_rounded,
                                            color: greenColor,
                                            size: 28.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 18.h),

                            ///Product Category
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 4.w),
                                decoration: BoxDecoration(
                                  color: greenColor.withOpacity(0.3),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(4.r),
                                ),
                                child: Text(
                                  product.categoryType ?? '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: greenColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 7.h),

                            ///Product Name
                            Text(
                              product.name ?? '',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            ///Vendor Name & Product Price
                            Row(
                              children: [
                                Container(
                                    width: 30.w,
                                    height: 30.w,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    child: appCacheImg(
                                        '${product.userModel?.profileImg?.link}',
                                        Icon(
                                          Icons.person,
                                          size: 22.h,
                                          color: Colors.grey.shade300,
                                        ))),
                                SizedBox(width: 6.w),
                                Text(
                                  product.userModel?.name ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: darkBlue,
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Text(
                                  '${product.price} ₪',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),

                            ///Product Description
                            Text(
                              product.description ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black.withOpacity(0.55),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Divider(
                              color: blackObacityColor,
                              thickness: .7.w,
                            ),
                            SizedBox(height: 12.h),

                            ///Product Comments
                            Text(
                              AppLocalizations.of(context)!.productComments,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///Add To Cart Action
                      MyButton(
                        onTap: () async => await _addToCart,
                        text: AppLocalizations.of(context)!.addToCart,
                        buttonColor: greenColor,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
      ),
    );
  }

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  Future<void> get _addToCart async {
    !_auth.loggedIn
        ? showMySnackBar(context,
            text: AppLocalizations.of(context)!.pleaseLoginToAdd, error: true)
        : _auth.user?.userType == UserType.buyer.name
            ? await _confirm
            : showMySnackBar(context,
                text: AppLocalizations.of(context)!.pleaseLoginAsBuyer, error: true);
  }

  Future<void> get _confirm async{
    var status = await CartFbController().addToCart(
        CartModel(
            id: const Uuid().v4(),
            product: widget.product,
            buyerId: _auth.user?.id));

    if (status) {
      if (context.mounted) {
        showMySnackBar(context, text: AppLocalizations.of(context)!.successfulProductAdded);
      }
    }
  }
}
