import '../../Screens/Buyer_Screens/buyer_product_view.dart';
import '../../Fierbase/controllers/product_fb_controller.dart';
import '../../Helper/navigator_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Helper/image_helper.dart';
import '../../Models/fb/product_model.dart';
import '../My_Widgets/my_button.dart';

class RecommendProductHomeSection extends StatefulWidget {

  const RecommendProductHomeSection({
    super.key,
  });

  @override
  State<RecommendProductHomeSection> createState() =>
      _RecommendProductHomeSectionState();
}

class _RecommendProductHomeSectionState
    extends State<RecommendProductHomeSection> with ImgHelper, NavigatorHelper {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          child: Text(
            AppLocalizations.of(context)!.recommendProducts,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: darkBlue, fontSize: 14.sp),
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
            height: 200.h,
            child: StreamBuilder(
              stream: ProductFbController().readProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<ProductModel> product =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsetsDirectional.only(start: 14.w, end: 14.w),
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: ()=> jump(context, to: BuyerProductViewPage(product: product[index])),
                        child: Container(
                          width: 120.w,
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadiusDirectional.all(Radius.circular(4.r)),
                            border: Border.all(width: 1.w, color: greyColor),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Product Img
                              Expanded(
                                child: Container(
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(4.r),
                                    ),
                                    child: appCacheImg(
                                        '${product[index].img?[0].link}',
                                        const SizedBox())),
                              ),
                              SizedBox(height: 4.h),

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
                                  '${product[index].categoryType}',
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
                                '${product[index].name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9.sp,
                                  color: darkBlue,
                                  height: 1.h,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.h),

                              ///Vendor Name & Price
                              Row(
                                children: [
                                  Container(
                                    width: 14.w,
                                    height: 14.w,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    child:appCacheImg('${product[index].userModel?.profileImg?.link}',
                                        Icon(
                                      Icons.person,
                                      size: 12.h,
                                      color: Colors.grey.shade300,
                                    ))
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '${product[index].userModel?.name}',
                                    style: TextStyle(
                                      fontSize: 7.5.sp,
                                      fontWeight: FontWeight.normal,
                                      color: darkBlue,
                                      height: 1.h,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    '${product[index].price} ₪',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue,
                                      height: 1.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.h),

                              ///Actions
                              Row(
                                children: [
                                  MyButton(
                                    text: AppLocalizations.of(context)!.addToCart,
                                    myFontSize: 5.5,
                                    myHeight: 22,
                                    myWidth: 62,
                                    buttonColor: greenColor,
                                    borderBouttonColor: Colors.transparent,
                                    onTap: () {},
                                  ),
                                  SizedBox(width: 10.w),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Icon(
                                      Icons.favorite_border_rounded,
                                      color: darkBlue,
                                      size: 20.h,
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 6.w),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )),
        SizedBox(height: 15.h),
      ],
    );
  }
}
