import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Models/fb/img_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Helper/converter_helper.dart';
import '../../../Helper/img_picker_helper.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Widgets/My_Widgets/my_rich_text.dart';
import '../../../Widgets/My_Widgets/my_text_field.dart';
import '../../../Helper/snack_bar_helper.dart';
import '../../../Fierbase/controllers/categories_fb_controller.dart';
import '../../../Fierbase/controllers/fb_storage_controller.dart';
import '../../../Models/fb/category_model.dart';

class InsertCategoryPage extends StatefulWidget {
  final CategoryModel? categoryModel;

  const InsertCategoryPage({
    this.categoryModel,
    super.key,
  });

  @override
  State<InsertCategoryPage> createState() => _InsertCategoryPageState();
}

class _InsertCategoryPageState extends State<InsertCategoryPage>
    with SnackBarHelper, ImgPickerHelper, ConverterHelper {
  late TextEditingController titleController;

  @override
  void initState() {
    titleController =
        TextEditingController(text: widget.categoryModel?.title ?? '');
    if (widget.categoryModel != null) {
      convertImg;
    }
    super.initState();
  }

  bool categoryImgLoading = false;

  Future<void> get convertImg async {
    setState(() => categoryImgLoading = true);
    var file =
        await convertImgLinkToFile(widget.categoryModel!.img!.link!);
    categoryImg = file;

    setState(() => categoryImgLoading = false);
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
          widget.categoryModel == null
              ? AppLocalizations.of(context)!.addCategory
              : AppLocalizations.of(context)!.editCategory,
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
                child: !categoryImgLoading ? categoryImg != null
                    ? Image.file(categoryImg!, fit: BoxFit.cover)
                    : Icon(
                        Icons.file_upload,
                        color: greyColor,
                        size: 43.h,
                      ) :const Center(child: CircularProgressIndicator(),),
                // child: categoryImg == null
                //     ? Icon(
                //         Icons.file_upload,
                //         color: greyColor,
                //         size: 34.w,
                //       )
                //     : categoryImgLoading
                //         ? Image.file(
                //             categoryImg!,
                //             fit: BoxFit.cover,
                //           )
                //         : const Center(
                //             child: CircularProgressIndicator(),
                //           ),
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
                  onTap: () async => await _performInsert(),
                  text: AppLocalizations.of(context)!.save,
                  myWidth: 135,
                  myHeight: 38,
                  borderBouttonColor: Colors.transparent,
                  buttonColor: greenColor,
                  myFontSize: 12,
                  loading: loading,
                ),
                MyButton(
                  onTap: () =>
                    Navigator.pop(context),
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

  Future<void> _performInsert() async {
    ///before create account
    if (checkData()) {
      await _insertCategory();
    }
  }

  Future<void> _insertCategory() async {
    String uuid = const Uuid().v4();
    setState(() => loading = true);
    ImgModel? imgModel = await FbStorageController()
        .uploadFileToStorage(categoryImg, folderName: 'categoryImg/$uuid');

    var status = widget.categoryModel == null
        ? await CategoriesFbController().createCategory(CategoryModel(
            id: uuid,
            img: imgModel,
            title: titleController.text,
            timestamp: Timestamp.now(),
          ))
        : await CategoriesFbController().updateCategory(CategoryModel(
            id: widget.categoryModel!.id,
            img: null,
            title: titleController.text,
            timestamp: Timestamp.now(),
          ));
    if (status) {
      showMySnackBar(context,
          text: widget.categoryModel == null
              ? AppLocalizations.of(context)!.successfulCategoryAdded
              : AppLocalizations.of(context)!.successfulCategoryEdited);
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
