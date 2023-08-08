import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Fierbase/controllers/product_fb_controller.dart';
import '../../../Models/fb/product_model.dart';
import '../../../Widgets/My_Widgets/my_button.dart';

class ManageProductPage extends StatefulWidget {
  const ManageProductPage({super.key});

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            AppLocalizations.of(context)!.productManaging,
            style: bnbTitlestyle,
          ),
          SizedBox(height: 10.h),
          StreamBuilder(
            stream: ProductFbController().readProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 240.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<ProductModel> products =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsetsDirectional.zero,
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6.w, vertical: 6.h),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(14.r),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: .8.w)),
                          child: Column(
                            children: [
                              ///product id
                              // Row(
                              //   children: [
                              //     Text(
                              //       'Product Id : ',
                              //       style: TextStyle(
                              //           fontSize: 13.sp,
                              //           fontWeight: FontWeight.w600,
                              //           color: darkBlue,
                              //           fontFamily: 'TitilliumWeb'),
                              //     ),
                              //     Text(
                              //       '${products[index].productId}',
                              //       style: TextStyle(
                              //           fontSize: 13.sp, color: darkBlue),
                              //     ),
                              //   ],
                              // ),

                              ///product name
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.productName} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${products[index].name}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///vendor product name
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.vendorName} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${products[index].vendorName}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///product category
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.productCategory} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${products[index].categoryType}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///product price
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.productPrice} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${products[index].price.toString()} ₪',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///product description
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.productDescription} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${products[index].description}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///product timestamp
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.timestamp} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${products[index].timestamp!.toDate()}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///product img
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.productImage} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Container(
                                    height: 70.h,
                                    width: 70.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8.r)),
                                    child: CachedNetworkImage(
                                      imageUrl: products[index]
                                          .img![0]
                                          .link!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: Text(
                                  //    '${products[index].productImg![index].link}',
                                  //     style: TextStyle(fontSize: 13.sp, color: darkBlue),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                            top: 7.h,
                            end: 5.w,
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                14.r),
                                      ),
                                      child: Container(
                                        width: 234.w,
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 20.w,
                                                vertical: 22.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .doYouWantToDeleteThisProduct,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: darkBlue,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .deleteProductParagraph,
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: darkBlue),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 10.h),

                                            ///Delete Product Action
                                            MyButton(
                                              onTap: () async {
                                                Navigator.pop(context);
                                                await ProductFbController()
                                                    .deleteProduct(
                                                        products[index]);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .delete,
                                              buttonColor: greenColor,
                                              myWidth: 135,
                                              myHeight: 38,
                                              myFontSize: 12,
                                            ),
                                            SizedBox(height: 16.h),

                                            ///Cancel
                                            MyButton(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .cancel,
                                              buttonColor: Colors.transparent,
                                              myWidth: 135,
                                              myHeight: 38,
                                              myFontSize: 12,
                                              borderBouttonColor: greenColor,
                                              textButtonColor: greenColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                              ),
                            )),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 240.h),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.theresNoProductsYet,
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.normal,
                          color: blackObacityColor),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
