import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Fierbase/controllers/cart_fb_controller.dart';
import '../../Fierbase/controllers/product_fb_controller.dart';

import '../../Helper/image_helper.dart';
import '../../Helper/snack_bar_helper.dart';
import '../../Models/fb/cart_model.dart';
import '../../Models/fb/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/fb/product_model.dart';
import '../../Providers/auth_provider.dart';
import '../../Widgets/My_Widgets/my_button.dart';
import '../../Widgets/My_Widgets/my_list_item.dart';
import '../../enums.dart';
import 'buyer_product_view.dart';

class ViewVendorProfile extends StatefulWidget {
  final UserModel user;

  const ViewVendorProfile({required this.user, super.key});

  @override
  State<ViewVendorProfile> createState() => _ViewVendorProfileState();
}

class _ViewVendorProfileState extends State<ViewVendorProfile>
    with NavigatorHelper, ImgHelper , SnackBarHelper{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        //toolbarHeight: 70.h,
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
          widget.user.name ?? '',
          style: textAppBarStyle,
        ),
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => _vendorPageOptionsBottomSheet(context),
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 14.w, vertical: 10.h),
                width: double.infinity.w,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Profile Img
                    Container(
                        width: 80.w,
                        height: 80.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: appCacheImg(
                          '${widget.user.profileImg?.link}',
                          Icon(
                            Icons.person,
                            size: 60.h,
                            color: Colors.grey.shade300,
                          ),
                        )),
                    SizedBox(
                      height: 3.h,
                    ),

                    ///Vendor Name
                    Text(
                      widget.user.name ?? '',
                      style: textStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),

                    ///Bio
                    Text(
                      widget.user.description ?? '',
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF000000).withOpacity(0.55)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  StreamBuilder(
                    stream: ProductFbController().showUserProducts(widget.user),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 80.h),
                              child: const CircularProgressIndicator(),
                            ));
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        List<ProductModel> product =
                            snapshot.data!.docs.map((e) => e.data()).toList();
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 14.w),
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
                                  to: BuyerProductViewPage(
                                      product: product[index])),
                              child: Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 4.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(4.r),
                                  border:
                                      Border.all(width: 1.w, color: greyColor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Product Img
                                    Expanded(
                                      child: Container(
                                          width: double.infinity,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(4.r),
                                          ),
                                          child: appCacheImg(
                                              product[index].img![0].link,
                                              const SizedBox())),
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
                                            BorderRadiusDirectional.circular(
                                                4.r),
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
                                    SizedBox(height: 7.h),

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
                                    SizedBox(height: 6.h),

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
                                          child:appCacheImg('${widget.user.profileImg?.link}',
                                              Icon(
                                            Icons.person,
                                            size: 12.h,
                                            color: Colors.grey.shade300,
                                          )),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          '${product[index].userModel?.name}',
                                          style: TextStyle(
                                            fontSize: 7.5.sp,
                                            fontWeight: FontWeight.normal,
                                            color: darkBlue,
                                            height: 1.h,
                                          ),
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

                                    ///Actions
                                    Row(
                                      children: [
                                        MyButton(
                                          text: AppLocalizations.of(context)!
                                              .addToCart,
                                          myFontSize: 5,
                                          myHeight: 21,
                                          myWidth: 60,
                                          buttonColor: greenColor,
                                          borderBouttonColor:
                                              Colors.transparent,
                                          onTap: () async => _addToCart(product[index]),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          child: Icon(
                                            Icons.favorite_border_rounded,
                                            color: darkBlue,
                                            size: 21.h,
                                          ),
                                          onTap: () {},
                                        ),
                                        SizedBox(width: 6.w),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  Future<void>  _addToCart(ProductModel product) async {
    !_auth.loggedIn
        ? showMySnackBar(context,
        text: AppLocalizations.of(context)!.pleaseLoginToAdd, error: true)
        : _auth.user?.userType == UserType.buyer.name
        ? await _confirm(product)
        : showMySnackBar(context,
        text: AppLocalizations.of(context)!.pleaseLoginAsBuyer, error: true);
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
  
  Future<dynamic> _vendorPageOptionsBottomSheet(BuildContext context) {
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

                ///Send Msg
                MyListItem(
                  text: AppLocalizations.of(context)!.sendMsg,
                  icon: Icons.message_rounded,
                  size: 21.w,
                  onTap: () {},
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(
                  height: 18.h,
                ),

                ///Share Profile
                MyListItem(
                  text: AppLocalizations.of(context)!.shareProfile,
                  icon: Icons.share_rounded,
                  size: 21.w,
                  onTap: () {},
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: greyColor,
                  height: 0.3.h,
                ),
                SizedBox(
                  height: 18.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
