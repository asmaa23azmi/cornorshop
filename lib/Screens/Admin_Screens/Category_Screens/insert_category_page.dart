import 'dart:io';

import 'package:cornorshop/Fierbase/controllers/categories_fb_controller.dart';
import 'package:cornorshop/Models/fb/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Helper/img_picker_helper.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Widgets/My_Widgets/my_rich_text.dart';
import '../../../Widgets/My_Widgets/my_text_field.dart';
import '../../../Helper/snack_bar_helper.dart';

class InsertCategoryPage extends StatefulWidget {
  const InsertCategoryPage({super.key});

  @override
  State<InsertCategoryPage> createState() => _InsertCategoryPageState();
}

class _InsertCategoryPageState extends State<InsertCategoryPage>
    with SnackBarHelper, ImgPickerHelper {
  late TextEditingController titleController;

  @override
  void initState() {
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  File? categoryImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        title: Text(
          AppLocalizations.of(context)!.addCategory,
          style: textAppBarStyle,
        ),
        centerTitle: true,
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
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 90.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Category img
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                categoryImg = await pickImageFromGallery();
                setState(() {});
              },
              child: Container(
                width: 140.h,
                height: 140.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, shape: BoxShape.circle),
                child: categoryImg == null
                    ? Icon(
                        Icons.file_upload,
                        color: greyColor,
                        size: 34.w,
                      )
                    : Image.file(
                        categoryImg!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              AppLocalizations.of(context)!.categoryImg,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14.0.sp,
                color: darkBlue,
              ),
            ),
            SizedBox(height: 20.h),

            ///Category name
            MyRichText(text: AppLocalizations.of(context)!.categoryName),
            SizedBox(height: 3.h),
            MyTextField(
                controller: titleController,
                hintText: AppLocalizations.of(context)!.enterCategoryName,
                textFieldBorderColor: blackObacityColor),
            SizedBox(height: 80.h),

            ///Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyButton(
                  onTap: () async => await _performAdd(),
                  text: AppLocalizations.of(context)!.save,
                  myWidth: 135,
                  myHeight: 38,
                  borderBouttonColor: Colors.transparent,
                  buttonColor: greenColor,
                  myFontSize: 12,
                  loading: loading,
                ),
                MyButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: AppLocalizations.of(context)!.cancel,
                  myWidth: 135,
                  myHeight: 38,
                  borderBouttonColor: greenColor,
                  buttonColor: Colors.transparent,
                  textButtonColor: greenColor,
                  myFontSize: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool loading = false;

  Future<void> _performAdd() async {
    ///before create account
    if (checkData()) {
      await _addCategory();
    }
  }

  Future<void> _addCategory() async {
    setState(() => loading = true);
    var status = await CategoriesFbController().create(CategoryModel(
        categoryId: const Uuid().v4(),
        categoryImg: null,
        categoryTitle: titleController.text));
    if (status) {
      //ToDo: create snack bar for success add category
      Navigator.pop(context);
    }
    setState(() => loading = false);
  }

  bool checkData() {
    ///to check text field
    if (categoryImg == null) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterCategoryImg, error: true);
      return false;
    } else if (titleController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.enterCategoryName, error: true);
      return false;
    }
    return true;
  }
}
