import 'package:cornorshop/Screens/Buyer_Screens/buyer_product_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Fierbase/controllers/favorite_fb_controller.dart';
import '../../Models/fb/favorit_model.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Models/fb/cart_model.dart';
import '../../Models/fb/product_model.dart';
import '../../Providers/auth_provider.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../enums.dart';
import '../../Fierbase/controllers/cart_fb_controller.dart';
import '../../Helper/image_helper.dart';
import '../../Helper/navigator_helper.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with ImgHelper , NavigatorHelper, SnackBarHelper{

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

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
                height: 12.h
              ),
              _auth.loggedIn
              ? StreamBuilder(
                stream: FavoriteFbController().readFavoriteProduct(_auth.user!.id!),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: 80.h),
                          child: const CircularProgressIndicator(),
                        ));
                  }else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
                    List<FavoriteModel> favoriteProducts =snapshot.data!.docs.map((e) => e.data()).toList() ;
                    return Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsetsDirectional.zero,
                        shrinkWrap: true,
                        itemCount: favoriteProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //This value is use to determine the layout in GridView(childAspectRatio).
                          childAspectRatio: 120.w / 176.h,
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: ()=> jump(context, to: BuyerProductViewPage(product: favoriteProducts[index].product!)),
                            child: Container(
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
                                      child: appCacheImg('${favoriteProducts[index].product?.img![0].link}', const  SizedBox()),
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
                                      '${favoriteProducts[index].product?.categoryType}',
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
                                    '${favoriteProducts[index].product?.name}',
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
                                        '${favoriteProducts[index].product?.userModel?.name}',
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.normal,
                                          color: darkBlue,
                                          height: 1.h,
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Text(
                                        '${favoriteProducts[index].product?.price} ₪',
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
                                        onTap: () async => _addToCart(favoriteProducts[index].product!),
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
              : Padding(
                padding: EdgeInsets.symmetric(vertical: 220.h),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.logInToShowFavorite,
                    style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.normal,
                        color: blackObacityColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Add To Cart
  Future<void>  _addToCart(ProductModel product) async {
    !_auth.loggedIn
        ? showMySnackBar(context,
        text: AppLocalizations.of(context)!.pleaseLoginToAdd, error: true)
        : _auth.user?.userType == UserType.buyer.name
        ? await _confirm(product)
        : showMySnackBar(context, text: AppLocalizations.of(context)!.pleaseLoginAsBuyer, error: true);
  }

  Future<void>  _confirm(ProductModel product) async{
    var status = await CartFbController().addToCart(
        CartModel(
            id: const Uuid().v4(),
            product: product,
            buyerId: _auth.user?.id));

    if (status) {
      if (context.mounted) {
        showMySnackBar(context, text: AppLocalizations.of(context)!.successfulProductAdded);
      }
    }
  }
}
