import 'package:cornorshop/Widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Models/product_model.dart';
class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List <ProductModel> product= [
    ProductModel(
        productId: 1,
        productName: 'كيكة الكريمة',
        productPrice: 25.0,
        productImg: ['cake'],
        productCategoryType: 'طعام وحلويات منزلية',
        vendorName: 'اسم المتجر'),
    ProductModel(
        productId: 2,
        productName: 'مسخن رول _ عدد 1 ',
        productPrice: 2.0,
        productImg: ['food'],
        productCategoryType: 'طعام وحلويات منزلية',
        vendorName: 'اسم المتجر'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w , vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.cartBar, style: bnbTitlestyle,),
              SizedBox(height: 18.h,),
              Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsetsDirectional.zero,
                    shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                         // height: 90.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(4.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(0.15),
                                blurRadius: 4,
                                offset: const Offset(0, 2),),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 105.w,
                               // height: 90.h,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(4.r),
                                      bottomStart: Radius.circular(4.r),),
                                  color: grayColor,
                                ),
                                child: Image.asset('assets/images/${product[index].productImg[0]}.png',
                                  fit: BoxFit.cover,),
                              ),
                              SizedBox(width: 23.w,),
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product[index].productName, style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.normal,
                                      color: darkBlue,
                                    ),),
                                    SizedBox(height: 6.h,),
                                    Row(
                                      children: [
                                        Text(product[index].vendorName, style: TextStyle(
                                          fontSize: 6.sp,
                                          fontWeight: FontWeight.normal,
                                          color: darkBlue,
                                        ),),
                                        SizedBox(width: 5.w,),
                                        Text('${product[index].productPrice}', style: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold,
                                          color: darkBlue,
                                        ),),
                                      ],
                                    ),
                                    SizedBox(height: 14.h,),
                                    Row(
                                      children: [
                                        MyButton(text: AppLocalizations.of(context)!.addToCart,myFontSize: 6.sp,
                                            myHeight: 20.h, myWidth: 93.w, buttonColor: orangeColor, borderBouttonColor: Colors.transparent,
                                            onTap: (){},),
                                        SizedBox(width: 16.w,),
                                        InkWell(child: Icon(Icons.favorite_border_outlined, color: darkBlue, size: 11.w,),onTap: (){},),
                                      ],),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 15.h,),
                     ),),
            ],
          ),
        ));
  }
}
