import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Fierbase/controllers/cart_fb_controller.dart';
import '../../Fierbase/controllers/favorite_fb_controller.dart';
import '../../Fierbase/controllers/product_fb_controller.dart';
import '../../Const/colors.dart';
import '../../Helper/image_helper.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Models/fb/cart_model.dart';
import '../../Models/fb/favorit_model.dart';
import '../../Models/fb/product_model.dart';
import '../../Providers/auth_provider.dart';
import '../../enums.dart';
import '../My_Widgets/my_button.dart';
import '../../Helper/navigator_helper.dart';
import '../../Screens/Buyer_Screens/buyer_product_view.dart';


class ProductListHomeSection extends StatefulWidget {
  const ProductListHomeSection({
    super.key});

  @override
  State<ProductListHomeSection> createState() => _ProductListHomeSectionState();
}

class _ProductListHomeSectionState extends State<ProductListHomeSection>
    with NavigatorHelper, ImgHelper, SnackBarHelper {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          child: Text(
            AppLocalizations.of(context)!.productsList,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: darkBlue,
                fontSize: 14.sp),
          ),
        ),
        SizedBox(height: 6.h),
        StreamBuilder(
          stream: ProductFbController().readProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<ProductModel> product = snapshot.data!.docs.map((e) =>
                  e.data()).toList();
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
                    onTap: () =>
                        jump(context,
                            to: BuyerProductViewPage(product: product[index])),
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
                              child: appCacheImg(
                                  product[index].img?[0].link,
                                  const SizedBox()),
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
                              '${product[index].categoryType}',
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
                            '${ product[index].name}',
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
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  child: appCacheImg(
                                      '${product[index].userModel?.profileImg
                                          ?.link}', Icon(
                                    Icons.person,
                                    size: 12.h,
                                    color: Colors.grey.shade300,
                                  ))
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${ product[index].userModel?.name}',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.normal,
                                  color: darkBlue,
                                  height: 1.h,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${product[index].price} ₪',
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
                              ///add to cart
                              MyButton(
                                text: AppLocalizations.of(context)!.addToCart,
                                myFontSize: 8,
                                myHeight: 25,
                                myWidth: 100,
                                buttonColor: greenColor,
                                borderBouttonColor: Colors.transparent,
                                onTap: () async =>
                                await _addToCart(product[index]),
                              ),
                              const Spacer(),
                              ///add to fav
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Icon(
                                  result ?  Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: darkBlue,
                                  size: 24.h,
                                ),
                                onTap: () async{
                                      if(result){
                                      _removeFromFav(product[index]);
                                      }else{
                                      await _addToFavorite(product[index]);
                                      }
                                   await _checkFavoriteStatus(product[index]);
                                      },
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
            } else {
              return const SizedBox();
            }
          },)
      ],
    );
  }

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);
  bool result = false;
  bool isCart = false;

  ///add to cart
  Future<void> _addToCart(ProductModel product) async {
    !_auth.loggedIn
        ? showMySnackBar(context,
        text: AppLocalizations.of(context)!.pleaseLoginToAdd, error: true)
        : _auth.user?.userType == UserType.buyer.name
        ? await _confirm(product)
        : showMySnackBar(
        context, text: AppLocalizations.of(context)!.pleaseLoginAsBuyer,
        error: true);
  }

  Future<void> _confirm(ProductModel product) async {
    var status = false;
    if (isCart) {
      product.quantity++;
      print(isCart);
    } else {
      status = await CartFbController().addToCart(CartModel(
          id: const Uuid().v4(),
          product: product,
          buyerId: _auth.user?.id));
    }

    if (status) {
      if (context.mounted) {
        showMySnackBar(context,
            text: AppLocalizations.of(context)!.successfulProductAdded);
      }
    }
  }

  Future<void>  _checkCartStatus(ProductModel product) async {

    bool isCarted =
    await CartFbController().show(product.id!, _auth.user?.id ?? '');
    print("Is Carted: $isCarted");
    setState(() => isCart = isCarted);
  }

  ///add to fav
  Future<void> _addToFavorite(ProductModel product) async {
    !_auth.loggedIn
        ? showMySnackBar(context,
        text: AppLocalizations.of(context)!.pleaseLoginToAddFav, error: true)
        : _auth.user?.userType == UserType.buyer.name
        ? await _confirmFavorite(product)
        : showMySnackBar(context,
        text: AppLocalizations.of(context)!.pleaseLoginAsBuyerFav, error: true);
  }

  Future<void> _confirmFavorite(ProductModel product) async {
    var status = await FavoriteFbController().addToFavorite(FavoriteModel(
        id: const Uuid().v4(),
        product: product,
        buyerId: _auth.user?.id));

    if (status) {
      if (context.mounted) {
        showMySnackBar(context,
            text: AppLocalizations.of(context)!.successfulProductAdded);
        // setState(() => favStatus  = status);
        // print('favStatus: ${favStatus}');
      }
    }
  }

  ///remove from fav
  Future<void> _removeFromFav(ProductModel product) async {
    await FavoriteFbController().removeFromFav(product);
  }

  Future<void> _checkFavoriteStatus(ProductModel product) async {
    bool isFavorite = await FavoriteFbController().show(
        product.id!, _auth.user?.id ?? '');
    print("Is Favorite: $isFavorite");
    setState(() => result = isFavorite);
  }
}
