import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Models/fb/user_model.dart';
import 'package:provider/provider.dart';
import '../../../Helper/converter_helper.dart';
import '../../../Models/fb/category_model.dart';
import '../../../Models/fb/img_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Providers/auth_provider.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Helper/snack_bar_helper.dart';
import '../../../Widgets/My_Widgets/my_dropdown_search.dart';
import '../../../Widgets/My_Widgets/my_rich_text.dart';
import '../../../Widgets/My_Widgets/my_text_field.dart';
import '../../../Helper/img_picker_helper.dart';
import '../../../Fierbase/controllers/fb_storage_controller.dart';
import '../../../Fierbase/controllers/product_fb_controller.dart';
import '../../../Models/fb/product_model.dart';

class InsertProductPage extends StatefulWidget {
  final ProductModel? productModel;

  const InsertProductPage({
    this.productModel,
    super.key,
  });

  @override
  State<InsertProductPage> createState() => _InsertProductPageState();
}

class _InsertProductPageState extends State<InsertProductPage>
    with SnackBarHelper, ImgPickerHelper, ConverterHelper {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productDescriptionController;

  String? selectedItem;

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    productNameController =
        TextEditingController(text: widget.productModel?.name ?? '');
    productPriceController = TextEditingController(
        text: widget.productModel?.price.toString() ?? '');
    productDescriptionController =
        TextEditingController(text: widget.productModel?.description ?? '');
    if (widget.productModel != null) {
      convertImg;
    }
  }

  bool productImgLoading = false;

  Future<void> get convertImg async {
    setState(() => productImgLoading = true);
    for (var item in widget.productModel!.img!) {
      var file = await convertImgLinkToFile(item.link);
      productImg.add(file);
      setState(() => productImgLoading = false);
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    productDescriptionController.dispose();
    super.dispose();
  }

  List<File> productImg = [];

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
        centerTitle: true,
        title: Text(
          widget.productModel == null
              ? AppLocalizations.of(context)!.addProduct
              : AppLocalizations.of(context)!.editProductDescription,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
          EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///Product Image
              MyRichText(text: AppLocalizations.of(context)!.enterProductImage),
              SizedBox(height: 3.h),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: widget.productModel == null
                    ? () async {
                  productImg.addAll(await pickMultiImagesFromGallery());
                  setState(() {});
                }
                    : null,
                child: Container(
                  width: double.infinity.w,
                  height: 180.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(14.r),
                    border: Border.all(
                      color: blackObacityColor,
                    ),
                  ),
                  child: productImg.isEmpty
                      ? Icon(
                    Icons.file_upload,
                    color: greyColor,
                    size: 40.w,
                  )

                  ///Show product img
                      : productImgLoading
                      ? ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 5.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: productImg.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              productImg[index],
                              fit: BoxFit.cover,
                            ),

                            ///Remove product from the img list
                            PositionedDirectional(
                                top: 5.h,
                                start: 5.w,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      // productImg.remove(productImg[index]);
                                      productImg.removeAt(index);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(width: 10.w),
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              ///Product Name
              MyRichText(text: AppLocalizations.of(context)!.enterProductName),
              SizedBox(height: 3.h),
              MyTextField(
                  controller: productNameController,
                  hintText: AppLocalizations.of(context)!.enterProductName,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(height: 12.h),

              ///Product Price
              MyRichText(text: AppLocalizations.of(context)!.enterProductPrice),
              SizedBox(height: 3.h),
              MyTextField(
                  controller: productPriceController,
                  hintText: AppLocalizations.of(context)!.enterProductPrice,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent,
                  inputType: TextInputType.number),
              SizedBox(height: 12.h),

              ///Product Category
              MyRichText(
                text: AppLocalizations.of(context)!.enterProductCategory,
              ),
              SizedBox(height: 3.h),
              MyDropdownSearch(
                callBack: (value) => selectedItem = value,
              ),
              SizedBox(height: 12.h),

              ///Product Description
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Text(
                  AppLocalizations.of(context)!.enterProductDescription,
                  style: textStyle,
                ),
              ),
              SizedBox(height: 3.h),
              MyTextField(
                controller: productDescriptionController,
                hintText: AppLocalizations.of(context)!.enterProductDescription,
                textFieldBorderColor: blackObacityColor,
                hintSyleColor: blackObacityColor,
                textFieldColor: Colors.transparent,
                maxLines: 6,
                textFieldHeigth: 100.h,
              ),
              SizedBox(height: 34.h),

              ///Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(
                    onTap: () async {
                      await _performConfirm();
                    },
                    text: AppLocalizations.of(context)!.publishProduct,
                    myWidth: 135,
                    myHeight: 40,
                    myFontSize: 12,
                    borderBouttonColor: Colors.transparent,
                    buttonColor: greenColor,
                    loading: loading,
                  ),
                  MyButton(
                      onTap: () => Navigator.pop(context, false),
                      text: AppLocalizations.of(context)!.cancel,
                      myWidth: 135,
                      myHeight: 40,
                      myFontSize: 12,
                      borderBouttonColor: greenColor,
                      buttonColor: Colors.transparent,
                      textButtonColor: greenColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Functions
  bool loading = false;

  Future<void> _performConfirm() async {
    ///before create account
    if (checkData()) {
      await _confirm();
    }
  }

  Future<void> _confirm() async {
    String uuid = const Uuid().v4();
    setState(() => loading = true);

    List<ImgModel> images = [];
    for (var img in productImg) {
      ImgModel? imgModel = await FbStorageController()
          .uploadFileToStorage(img, folderName: 'productImg/$uuid');
      if (imgModel != null) {
        images.add(imgModel);
      }
    }
    var status = widget.productModel == null
        ? await ProductFbController().createProduct(ProductModel(
        id: uuid,
        name: productNameController.text,
        price: num.parse(productPriceController.text),
        img: images,
        categoryType: selectedItem,
        description: productDescriptionController.text,
        timestamp: Timestamp.now(),
        userModel: _auth.user),)
        : await ProductFbController().updateProduct(ProductModel(
        id: widget.productModel!.id,
        name: productNameController.text,
        price: num.parse(productPriceController.text),
        img: widget.productModel?.img,
        categoryType: selectedItem,
        description: productDescriptionController.text,
        timestamp: Timestamp.now(),
        userModel: _auth.user
    ),);

    if (status) {
      if (context.mounted) {
        showMySnackBar(context,
            text: widget.productModel == null
                ? AppLocalizations.of(context)!.successfulProductAdded
                : AppLocalizations.of(context)!.successfulProductEdited);
        Navigator.pop(context, true);
      }
    }
    setState(() => loading = false);
  }

  bool checkData() {
    ///to check text field
    if (productImg.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterProductImage, error: true);
      return false;
    } else if (productNameController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterProductName, error: true);
      return false;
    } else if (productPriceController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterProductPrice, error: true);
      return false;
    } else if (selectedItem == null) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterProductCategory,
          error: true);
      return false;
    }
    return true;
  }
}
