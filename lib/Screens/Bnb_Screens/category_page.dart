import '../../Helper/image_helper.dart';
import '../../Fierbase/controllers/categories_fb_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/fb/category_model.dart';
import '../../Screens/Category_item_Screens/item_category_screen.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with NavigatorHelper, ImgHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        //toolbarHeight: 100.h,
        title: Text(
          AppLocalizations.of(context)!.categoryBar,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: CategoriesFbController().readCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    List<CategoryModel> categoryItems =
                        snapshot.data!.docs.map((e) => e.data()).toList();
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.zero,
                      itemCount: categoryItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            jump(context, to:  CategoryItemScreen(category: categoryItems[index]));
                          },
                          child: Row(
                            children: [
                              Container(
                                  height: 70.h,
                                  width: 70.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadiusDirectional.all(
                                          Radius.circular(12.r)),
                                      border: Border.all(
                                          color: greenColor, width: 1.w)),
                                  child: appCacheImg(
                                    categoryItems[index].img?.link  ?? '',
                                    Container(
                                      width: 70.h,
                                      height: 70.h,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),),
                              SizedBox(
                                width: 9.w,
                              ),
                              Text(
                                '${categoryItems[index].title}',
                                style: textStyle,
                              ),
                              const Spacer(
                                  //to position the widget in the end of the row
                                  ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: darkBlue,
                                size: 15.w,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Divider(
                              color: greyColor,
                              height: 0.3.h,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        );
                      },
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
