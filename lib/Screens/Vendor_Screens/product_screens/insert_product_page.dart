import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Widgets/my_button.dart';
import '../../../Helper/snack_bar_helper.dart';
import '../../../Widgets/my_dropdown_search.dart';
import '../../../Widgets/my_rich_text.dart';
import '../../../Widgets/my_text_field.dart';
import '../../../Helper/img_picker_helper.dart';

class InsertProductPage extends StatefulWidget {
  const InsertProductPage({super.key});

  @override
  State<InsertProductPage> createState() => _InsertProductPageState();
}

class _InsertProductPageState extends State<InsertProductPage>
    with SnackBarHelper, ImgPickerHelper {
  late TextEditingController productNameController;
  late TextEditingController productPriceController;
  late TextEditingController productDescriptionController;

  String? selectedItem;

  List<String> items = [
    'ملابس',
    'منتجات طبيعية',
    'طعام وحلويات منزلية',
    'مشغولات يدوية',
  ];

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    productPriceController = TextEditingController();
    productDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    productDescriptionController.dispose();
    super.dispose();
  }

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
          AppLocalizations.of(context)!.addProduct,
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
              MyRichText(text: AppLocalizations.of(context)!.productImage),
              SizedBox(
                height: 3.h,
              ),
              InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
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
                    child: Icon(
                      Icons.file_upload,
                      color: greyColor,
                      size: 40.w,
                    ),
                  )),
              SizedBox(
                height: 12.h,
              ),

              ///Product Name
              MyRichText(text: AppLocalizations.of(context)!.productName),
              SizedBox(
                height: 3.h,
              ),
              MyTextField(
                  controller: productNameController,
                  hintText: AppLocalizations.of(context)!.productName,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent),
              SizedBox(
                height: 12.h,
              ),

              ///Product Price
              MyRichText(text: AppLocalizations.of(context)!.productPrice),
              SizedBox(
                height: 3.h,
              ),
              MyTextField(
                  controller: productPriceController,
                  hintText: AppLocalizations.of(context)!.productPrice,
                  textFieldBorderColor: blackObacityColor,
                  hintSyleColor: blackObacityColor,
                  textFieldColor: Colors.transparent,
                  inputType: TextInputType.number),
              SizedBox(
                height: 12.h,
              ),

              ///Product Category
              MyRichText(
                text: AppLocalizations.of(context)!.productCategory,
              ),
              SizedBox(
                height: 3.h,
              ),
              MyDropdownSearch(
                items: items,
                onChange: (value) => selectedItem = value,
              ),
              SizedBox(
                height: 12.h,
              ),

              ///Product Description
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15.w),
                child: Text(
                  AppLocalizations.of(context)!.productDescription,
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              MyTextField(
                controller: productDescriptionController,
                hintText: AppLocalizations.of(context)!.productDescription,
                textFieldBorderColor: blackObacityColor,
                hintSyleColor: blackObacityColor,
                textFieldColor: Colors.transparent,
                maxLines: 6,
                textFieldHeigth: 100.h,
              ),
              SizedBox(
                height: 34.h,
              ),

              ///Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyButton(
                      onTap: () {
                        _performConfirm();
                      },
                      text: AppLocalizations.of(context)!.publishProduct,
                      myWidth: 135,
                      myHeight: 40,
                      myFontSize: 12,
                      borderBouttonColor: Colors.transparent,
                      buttonColor: greenColor),
                  MyButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
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

  void _performConfirm() {
    ///before create account
    if (checkData()) {
      _confirm();
    }
  }

  void _confirm() {}

  bool checkData() {
    ///to check text field
    if (productNameController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.productName, error: true);
      return false;
    } else if (productPriceController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.productPrice, error: true);
      return false;
    } else if (selectedItem == null) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.productCategory, error: true);
      return false;
    }
    return true;
  }
}
