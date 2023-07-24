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
      height: 170.h,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.only(start: 20.w),
        itemCount: widget.product.length,
        itemBuilder: (context, index) {
          return Container(
            //width: 110.h,
            //height: 300.h,
            width: 120.w,
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 4.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadiusDirectional.all(Radius.circular(4.r)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.15),
                  blurRadius: 2,
                  offset: const Offset(
                      0, 2), // changes position of shadow
                ),
              ],
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
                      'assets/images/${widget.product[index].productImg[0]}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),

                ///Product Category
                Container(
                  height: 15.h,
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 3.w),
                  decoration: BoxDecoration(
                    color: orangeColor.withOpacity(0.3),
                    borderRadius:
                    BorderRadiusDirectional.circular(4.r),
                  ),
                  child: Text(
                    widget.product[index].productCategoryType,
                    style: TextStyle(
                      fontSize: 6.5.sp,
                      color: orangeColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 7.h),

                ///Product Name
                Text(
                  widget.product[index].productName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 9.sp,
                    color: darkBlue,
                    height: 1.h,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

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
                      widget.product[index].vendorName,
                      style: TextStyle(
                        fontSize: 7.5.sp,
                        fontWeight: FontWeight.normal,
                        color: darkBlue,
                        height: 1.h,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      '${widget.product[index].productPrice} ₪',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                        color: darkBlue,
                        height: 1.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                ///Actions
                Row(
                  children: [
                    MyButton(
                      text: AppLocalizations.of(context)!.addToCart,
                      myFontSize: 5.5,
                      myHeight: 22,
                      myWidth: 62,
                      buttonColor: orangeColor,
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
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 4.w),
      ),
    );
  }
}
