import '../../Helper/image_helper.dart';
import '../../Helper/navigator_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Fierbase/controllers/product_fb_controller.dart';
import '../../Models/fb/product_model.dart';
import '../../Widgets/My_Widgets/my_button.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with ImgHelper , NavigatorHelper{

  List<ProductModel> product = [
    ProductModel(
      id: '1',
      name: 'كيكة الكريمة',
      price: 25.0,
      img: ['cake'],
      categoryType: null,
      quantity: 1, userModel: null,
    ),
    ProductModel(
      id: '2',
      name: 'مسخن رول _ عدد 1 ',
      price: 2.0,
      img: ['food'],
      categoryType: null,

      quantity: 1, userModel: null,
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        //  toolbarHeight: 100.h,
        title: Text(
          AppLocalizations.of(context)!.myFavProduct,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(
                AppLocalizations.of(context)!.myFavProduct,
                style: bnbTitlestyle,
              ),
              SizedBox(
                height: 12.h,
              ),
              StreamBuilder(
                stream: ProductFbController().getFavoriteProductsStream(),
                builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                            vertical: 80.h),
                        child: const CircularProgressIndicator(),
                      ));
                }else if(snapshot.hasData && snapshot.data!.isNotEmpty){
                  //List<ProductModel> favoriteProducts =snapshot.data!.map((e) => e.data()).toList() ;
                  return Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsetsDirectional.zero,
                      shrinkWrap: true,
                      itemCount: product.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //This value is use to determine the layout in GridView(childAspectRatio).
                        childAspectRatio: 120.w / 176.h,
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(4.r)),
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
                                  child: appCacheImg('${product[index].img![0].link}', const  SizedBox()),
                                ),
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
                                    '${product[index].userModel?.name}',
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.normal,
                                      color: darkBlue,
                                      height: 1.h,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
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
                                  SizedBox(width: 15.w),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 22.h,
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
                    ),
                  );
                }else{
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 240.h),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.noFavoriteYet,
                        style: TextStyle(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.normal,
                            color: blackObacityColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
