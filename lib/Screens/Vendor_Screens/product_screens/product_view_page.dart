import '../../../Fierbase/controllers/product_fb_controller.dart';
import '../../../Helper/image_helper.dart';
import '../../../Models/fb/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Widgets/My_Widgets/my_list_item.dart';
import '../../../Helper/navigator_helper.dart';
import '../../../Screens/Vendor_Screens/product_screens/insert_product_page.dart';
import '../../../Screens/Vendor_Screens/product_screens/Product_Promotion_Screens/product_promotion_target.dart';
import '../../Buyer_Screens/product_comments_page.dart';

class ProductViewPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductViewPage({required this.productModel, super.key});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage>
    with NavigatorHelper, ImgHelper {
  int selectedIndex = 0;

  late ProductModel product = widget.productModel;

  @override
  void initState() {
    super.initState();
  }

bool loading = false;
  Future<void> get _refresh async {
    setState(() => loading = true);
    var data = await ProductFbController().show(widget.productModel.id!);

    if (data != null) {
      setState(() => product = data);
    }
    setState(() => loading = false);
  }

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
        title: Text(
          AppLocalizations.of(context)!.productSpecifications,
          style: textAppBarStyle,
        ),

        ///Product Settings
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              _productSettingsBottomSheet(context);
            },
            child: Icon(
              Icons.more_vert_rounded,
              color: darkBlue,
              size: 28.h,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 14.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            child: StreamBuilder(
              stream: ProductFbController().readProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  ProductModel productModel = product;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              itemCount: productModel.img?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsetsDirectional.symmetric(
                                      horizontal: 10.w),
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(14.r),
                                  ),
                                  child: appCacheImg(
                                      productModel.img?[index].link,
                                      const SizedBox()),
                                );
                              },
                            ),
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
                                  itemCount: productModel.img!.length,
                                  itemBuilder: (context, index) {
                                    bool selected = selectedIndex == index;
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
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),

                      ///Product Category
                      Container(
                        //height: 15.h,
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: greenColor.withOpacity(0.3),
                          borderRadius: BorderRadiusDirectional.circular(4.r),
                        ),
                        child: Text(
                          productModel.categoryType ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: greenColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),

                      ///Product Name
                      Text(
                        productModel.name ?? '',
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
                              productModel.userModel?.profileImg?.link ?? '',
                              Icon(
                                Icons.person,
                                size: 22.h,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            productModel.userModel?.name ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: darkBlue,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Text(
                            '${productModel.price} ₪',
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
                        productModel.description ?? '',
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

                      SizedBox(height: 10.h),

                      ///display comment
                      InkWell(
                          onTap: ()=> jump(context, to:  ProductCommentPage(product: product)),
                          child: Text(AppLocalizations.of(context)!.viewComments,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12.sp
                            ),)),
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

  Future<dynamic> _productSettingsBottomSheet(BuildContext context) {
    ///Bottom Sheet
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(20.r), topEnd: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 26.w, vertical: 10.h),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                ///Black Divider
                Container(
                  height: 4,
                  margin: EdgeInsetsDirectional.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.4,
                      vertical: MediaQuery.of(context).size.height * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadiusDirectional.circular(2.r),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                ///Product Promotion
                MyListItem(
                  text: AppLocalizations.of(context)!.productPromotion,
                  icon: Icons.arrow_forward_ios,
                  size: 18.w,
                  onTap: () =>
                      jump(context, to: const ProductPromotionTargetPage()),
                ),
                SizedBox(height: 10.h),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(height: 18.h),

                ///Edit Product Description
                MyListItem(
                  text: AppLocalizations.of(context)!.editProductDescription,
                  icon: Icons.arrow_forward_ios,
                  size: 18.w,
                  onTap: () async {
                    Navigator.pop(context);
                    var result = await jump(context,
                        to: InsertProductPage(productModel: product));

                    if (result) {
                      await _refresh;
                    }
                  },
                ),
                SizedBox(height: 10.h),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(height: 18.h),

                ///Delete Product
                MyListItem(
                  text: AppLocalizations.of(context)!.deleteProduct,
                  icon: Icons.arrow_forward_ios,
                  size: 18.w,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadiusDirectional.circular(14.r),
                          ),
                          child: Container(
                            width: 234.w,
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 20.w, vertical: 22.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                      fontSize: 10.sp, color: darkBlue),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10.h),

                                ///Delete Product Action
                                MyButton(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    await ProductFbController()
                                        .deleteProduct(product);
                                  },
                                  text: AppLocalizations.of(context)!
                                      .deleteProduct,
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
                                  text: AppLocalizations.of(context)!.cancel,
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
                ),
                SizedBox(height: 10.h),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(height: 18.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
