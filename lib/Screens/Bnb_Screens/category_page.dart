import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/category_model.dart';
import '../../Screens/Category_item_Screens/item_category_screen.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with NavigatorHelper {
  List<CategoryModel> categoryItems = [
    CategoryModel(
      categoryId: 1,
      categoryImg: 'clothIcon',
      //categoryTitle: appLocale.cloth,
      categoryTitle: 'ملابس',
    ),
    CategoryModel(
      categoryId: 2,
      categoryImg: 'naturalProductIcon',
      //categoryTitle: AppLocalizations.of(context)!.naturalProduct,
      categoryTitle: 'منتجات طبيعية',
    ),
    CategoryModel(
      categoryId: 3,
      categoryImg: 'homeFoodIcon',
      // categoryTitle: AppLocalizations.of(context)!.homeFood,
      categoryTitle: 'طعام وحلويات منزلية',
    ),
    CategoryModel(
      categoryId: 4,
      categoryImg: 'handicraftsIcon',
      // categoryTitle: AppLocalizations.of(context)!.handicrafts,
      categoryTitle: 'مشغولات يدوية',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0.4,
        backgroundColor: whiteColor,
        //toolbarHeight: 100.h,
        title: Padding(
         padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: Text(
            AppLocalizations.of(context)!.categoryBar,
            style: textAppBarStyle,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsetsDirectional.zero,
                  itemCount: categoryItems.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        jump(context, to: const CategoryItemScreen());
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.h,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(12.r)),
                            ),
                            child: Image.asset(
                                'assets/images/${categoryItems[index].categoryImg}.png',
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Text(
                            categoryItems[index].categoryTitle,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
