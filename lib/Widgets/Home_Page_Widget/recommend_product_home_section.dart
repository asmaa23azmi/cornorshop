import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Models/product_model.dart';
import '../my_button.dart';

class RecommendProductHomeSection extends StatefulWidget {
  final List<ProductModel> product;

  const RecommendProductHomeSection({
    required this.product,
    super.key,
  });

  @override
  State<RecommendProductHomeSection> createState() =>
      _RecommendProductHomeSectionState();
}

class _RecommendProductHomeSectionState
    extends State<RecommendProductHomeSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.zero,
        itemCount: widget.product.length,
        itemBuilder: (context, index) {
          return Container(
            //width: 110.h,
            //height: 300.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(4.r)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.15),
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
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
                    width: 105.w,
                    height: 90.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadiusDirectional.circular(4.r),
                    ),
                    child: Image.asset(
                      'assets/images/${widget.product[index].productImg[0]}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),

                  ///Product Category
                  Container(
                    height: 15.h,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: orangeColor.withOpacity(0.3),
                      borderRadius: BorderRadiusDirectional.circular(4.r),
                    ),
                    child: Text(
                      widget.product[index].productCategoryType,
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
                      widget.product[index].productName,
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
                          widget.product[index].vendorName,
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
                          '${widget.product[index].productPrice} ₪',
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

                  ///Actions
                  Expanded(
                    child: Row(
                      children: [
                        MyButton(
                          text: AppLocalizations.of(context)!.addToCart,
                          myFontSize: 5.sp,
                          myHeight: 35.h,
                          myWidth: 60.w,
                          buttonColor: orangeColor,
                          borderBouttonColor: Colors.transparent,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
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
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 4.w),
      ),
    );
  }
}
