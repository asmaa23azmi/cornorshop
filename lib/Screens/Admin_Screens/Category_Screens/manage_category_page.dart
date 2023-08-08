import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Fierbase/controllers/categories_fb_controller.dart';
import '../../../Fierbase/controllers/fb_storage_controller.dart';
import '../../../Models/fb/category_model.dart';
import '../../../Helper/navigator_helper.dart';
import '../../../Screens/Admin_Screens/Category_Screens/insert_category_page.dart';
import '../../../Widgets/My_Widgets/my_button.dart';

class ManageCategoryPage extends StatefulWidget {
  const ManageCategoryPage({super.key});

  @override
  State<ManageCategoryPage> createState() => _ManageCategoryPageState();
}

class _ManageCategoryPageState extends State<ManageCategoryPage>
    with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.categoryManaging,
                style: bnbTitlestyle,
              ),
              const Spacer(),
              InkWell(
                onTap: () => jump(context, to: const InsertCategoryPage()),
                child: Icon(
                  Icons.add,
                  color: greenColor,
                  size: 30.h,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          StreamBuilder(
            stream: CategoriesFbController().readCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 240.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<CategoryModel> categoryItems =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsetsDirectional.zero,
                  shrinkWrap: true,
                  itemCount: categoryItems.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6.w, vertical: 6.h),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(14.r),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: .8.w)),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 20.w),
                            child: Column(
                              children: [
                                ///category id
                                // Row(
                                //   children: [
                                //     Text(
                                //       'Category Id : ',
                                //       style: TextStyle(
                                //           fontSize: 13.sp,
                                //           fontWeight: FontWeight.w600,
                                //           color: darkBlue,
                                //           fontFamily: 'TitilliumWeb'),
                                //     ),
                                //     Expanded(
                                //       child: Text(
                                //         '${categoryItems[index].categoryId}',
                                //         style: TextStyle(
                                //             fontSize: 13.sp, color: darkBlue),
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                ///category name
                                Row(
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context)!.categoryName} : ',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: darkBlue),
                                    ),
                                    Text(
                                      '${categoryItems[index].title}',
                                      style: TextStyle(
                                          fontSize: 13.sp, color: darkBlue),
                                    ),
                                  ],
                                ),

                                ///category timestamp
                                Row(
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context)!.timestamp} : ',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: darkBlue),
                                    ),
                                    Text(
                                      '${categoryItems[index].timestamp!.toDate()}',
                                      //'',
                                      style: TextStyle(
                                          fontSize: 13.sp, color: darkBlue),
                                    ),
                                  ],
                                ),

                                ///category img
                                Row(
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context)!.categoryImg} : ',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: darkBlue),
                                    ),
                                    Container(
                                      height: 70.h,
                                      width: 70.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r)
                                      ),
                                      child: CachedNetworkImage(imageUrl: categoryItems[index].img!.link!, fit: BoxFit.cover,),
                                    ),
                                    // Expanded(
                                    //   child: Text(
                                    //     '${categoryItems[index].categoryImg!.link}',
                                    //     style: TextStyle(
                                    //         fontSize: 13.sp, color: darkBlue),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        PositionedDirectional(
                            top: 7.h,
                            end: 5.w,
                            child: Row(
                              children: [
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () => jump(context,
                                      to: InsertCategoryPage(
                                        categoryModel: categoryItems[index],
                                      )),
                                  child: const Icon(
                                    Icons.edit,
                                    color: greyColor,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(14.r),
                                          ),
                                          child: Container(
                                            width: 234.w,
                                            padding:
                                                EdgeInsetsDirectional.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 22.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .doYouWantToDeleteThisCategory,
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: darkBlue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .deleteCategoryParagraph,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: darkBlue),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 10.h),

                                                ///Delete Product Action
                                                MyButton(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await CategoriesFbController()
                                                        .deleteCategory(
                                                            categoryItems[
                                                                index]);
                                                    await FbStorageController()
                                                        .deleteFile(
                                                            '${categoryItems[index].id}/');
                                                  },
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .delete,
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
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .cancel,
                                                  buttonColor:
                                                      Colors.transparent,
                                                  myWidth: 135,
                                                  myHeight: 38,
                                                  myFontSize: 12,
                                                  borderBouttonColor:
                                                      greenColor,
                                                  textButtonColor: greenColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 240.h),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.theresNoCategoriesYet,
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
      ),
    );
  }
}
