import 'package:cornorshop/Providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../Helper/image_helper.dart';
import '../../../Screens/Vendor_Screens/product_screens/product_view_page.dart';
import '../../../Const/colors.dart';
import '../../../Helper/navigator_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Fierbase/controllers/product_fb_controller.dart';
import '../../../Models/fb/product_model.dart';

class VendorProductList extends StatefulWidget {
  const VendorProductList({super.key});

  @override
  State<VendorProductList> createState() => _VendorProductListState();
}

class _VendorProductListState extends State<VendorProductList> with NavigatorHelper, ImgHelper{
  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        StreamBuilder(
          stream: ProductFbController().showUserProducts(_auth.user!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        vertical: 80.h),
                    child: const CircularProgressIndicator(),
                  ));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<ProductModel> product = snapshot.data!.docs
                  .map((e) => e.data())
                  .toList();
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 14.w),
                shrinkWrap: true,
                itemCount: product.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  //This value is use to determine the layout in GridView(childAspectRatio).
                  childAspectRatio: 110.w / 160.h,
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => jump(context,
                        to: ProductViewPage(
                            productModel: product[index])),
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 4.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadiusDirectional.circular(4.r),
                        border: Border.all(
                            width: 1.w, color: greyColor),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                                BorderRadiusDirectional
                                    .circular(4.r),
                              ),
                              child: appCacheImg(
                                  product[index].img?[0].link,
                                  const SizedBox()),
                            ),
                          ),
                          SizedBox(height: 5.h),

                          ///Product Category
                          Container(
                            height: 16.h,
                            padding:
                            EdgeInsetsDirectional.symmetric(
                                horizontal: 3.w),
                            decoration: BoxDecoration(
                              color: greenColor.withOpacity(0.3),
                              borderRadius:
                              BorderRadiusDirectional
                                  .circular(4.r),
                            ),
                            child: Text(
                              product[index].categoryType ?? '',
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
                            product[index].name ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp,
                              color: darkBlue,
                              height: 1.h,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),

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
                                  child: appCacheImg(
                                    '${product[index].userModel?.profileImg?.link}',
                                    Icon(
                                      Icons.person,
                                      size: 12.h,
                                      color: Colors.grey.shade300,
                                    ),
                                  )),
                              SizedBox(width: 2.w),
                              Text(
                                product[index].userModel?.name ??
                                    '',
                                style: TextStyle(
                                  fontSize: 7.5.sp,
                                  fontWeight: FontWeight.normal,
                                  color: darkBlue,
                                  height: 1.h,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                '${product[index].price} ₪',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: darkBlue,
                                  height: 1.h,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 150.h),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!
                        .theresNoProductsYet,
                    style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.normal,
                        color: blackObacityColor),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
