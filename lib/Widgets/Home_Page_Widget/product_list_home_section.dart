import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/colors.dart';
import '../../Models/product_model.dart';

class ProductListHomeSection extends StatefulWidget {
  const ProductListHomeSection({super.key});

  @override
  State<ProductListHomeSection> createState() => _ProductListHomeSectionState();
}

class _ProductListHomeSectionState extends State<ProductListHomeSection> {
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
    ProductModel(
      productId: 3,
      productName: 'قميص شتوي ',
      productPrice: 70.0,
      productImg: ['shirt'],
      productCategoryType: 'ملابس',
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
    ProductModel(
      productId: 3,
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
    var size = MediaQuery.of(context).size;

    ///This value is use to determine the layout in GridView(childAspectRatio).
    final double itemHeight = (size.height - kToolbarHeight - 190) / 2;
    final double itemWidth = size.width / 2;

    return Expanded(
      child: Column(
        children: [
          GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            shrinkWrap: true,
            itemCount: product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (itemWidth.w / itemHeight.h),
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1),
            itemBuilder: (context, index) {
              return Container(
                //width: 110.h,
                //height: 300.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.15),
                      blurRadius: 2,
                      offset: const Offset(
                          0, 2), // changes position of shadow
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
                        width: 125.w,
                        height: 90.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius:
                          BorderRadiusDirectional.circular(4.r),
                        ),
                        child: Image.asset(
                          'assets/images/${product[index].productImg[0]}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),

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
                          product[index].productCategoryType,
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
                          product[index].productName,
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
                              product[index].vendorName,
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
                              '${product[index].productPrice} ₪',
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
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

