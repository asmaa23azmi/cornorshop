import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Const/colors.dart';
import '../../Models/fb/product_model.dart';
import '../My_Widgets/my_button.dart';
import '../../Helper/navigator_helper.dart';
import '../../Screens/Buyer_Screens/buyer_product_view.dart';


class ProductListHomeSection extends StatefulWidget {
  const ProductListHomeSection({super.key});

  @override
  State<ProductListHomeSection> createState() => _ProductListHomeSectionState();
}

class _ProductListHomeSectionState extends State<ProductListHomeSection> with NavigatorHelper{
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
    ProductModel(
      productId: '3',
      productName: 'قميص شتوي ',
      productPrice: 70.0,
      productImg: ['shirt'],
      productCategoryType: 'ملابس',
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
    ProductModel(
      productId: '3',
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

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
      shrinkWrap: true,
      itemCount: product.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //This value is use to determine the layout in GridView(childAspectRatio).
        childAspectRatio: 110.w / 160.h,
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => jump(context, to: const BuyerProductViewPage()),
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 4.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadiusDirectional.circular(4.r),
              border: Border.all(width: 1.w, color: greyColor),
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
                      'assets/images/${product[index].productImg[0]}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 7.h),

                ///Product Category
                Container(
                  height: 18.h,
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 3.w),
                  decoration: BoxDecoration(
                    color: greenColor.withOpacity(0.3),
                    borderRadius:
                    BorderRadiusDirectional.circular(4.r),
                  ),
                  child: Text(
                    product[index].productCategoryType,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: greenColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                ///Product Name
                Text(
                  product[index].productName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
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
                      width: 16.w,
                      height: 16.w,
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
                    SizedBox(width: 4.w),
                    Text(
                      product[index].vendorName,
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.normal,
                        color: darkBlue,
                        height: 1.h,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${product[index].productPrice} ₪',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: darkBlue,
                        height: 1.h,
                      ),
                    ),
                    SizedBox(width: 20.w,)
                  ],
                ),
                SizedBox(height: 7.h),

                ///Actions
                Row(
                  children: [
                    MyButton(
                      text: AppLocalizations.of(context)!.addToCart,
                      myFontSize: 8,
                      myHeight: 25,
                      myWidth: 100,
                      buttonColor: greenColor,
                      borderBouttonColor: Colors.transparent,
                      onTap: () {},
                    ),
                    const Spacer(),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: darkBlue,
                        size: 24.h,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(width: 24.w,)
                  ],
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

