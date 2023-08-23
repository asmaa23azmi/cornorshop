import 'package:cornorshop/Screens/Buyer_Screens/buyer_product_view.dart';

import '../../Helper/navigator_helper.dart';

import '../../Fierbase/controllers/product_fb_controller.dart';
import '../../Helper/image_helper.dart';
import '../../Models/fb/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Models/fb/product_model.dart';
import '../../Widgets/My_Widgets/my_button.dart';

class CategoryItemScreen extends StatefulWidget {
  final CategoryModel? category;

  const CategoryItemScreen({required this.category, super.key});

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen>
    with ImgHelper , NavigatorHelper{
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
          widget.category?.title ?? '',
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 14.w, vertical: 14.h),
            child: StreamBuilder(
              stream: ProductFbController().showCategoryProducts(widget.category?.title ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<ProductModel> product =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsetsDirectional.zero,
                    shrinkWrap: true,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: ()=> jump(context, to: BuyerProductViewPage(product: product[index])),
                        child: Container(
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
                                  borderRadius:
                                      BorderRadiusDirectional.circular(4.r),
                                  color: Colors.grey.shade200,
                                ),
                                child: appCacheImg(product[index].img?[0].link,
                                    const SizedBox()),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),

                              ///Product Details
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 10.h),
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
                                          '${product[index].userModel?.name}',
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
                                          text: AppLocalizations.of(context)!
                                              .addToCart,
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
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15.h,
                    ),
                  );
                } else {
                  return  Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .noProductInCategory,
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.normal,
                          color: blackObacityColor),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            )),
      ),
    );
  }
}
