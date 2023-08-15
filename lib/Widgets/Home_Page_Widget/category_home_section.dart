import '../../Const/texts.dart';
import '../../Helper/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/fb/category_model.dart';
import '../../Fierbase/controllers/categories_fb_controller.dart';
import '../../Screens/Bnb_Screens/category_page.dart';
import '../../Screens/Category_item_Screens/item_category_screen.dart';

class CategoryHomeSection extends StatefulWidget {
  const CategoryHomeSection({
    super.key,
  });

  @override
  State<CategoryHomeSection> createState() => _CategoryHomeSectionState();
}

class _CategoryHomeSectionState extends State<CategoryHomeSection>
    with NavigatorHelper, ImgHelper {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CategoriesFbController().readCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<CategoryModel> categoryItems =
              snapshot.data!.docs.map((e) => e.data()).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.categoryBar,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: darkBlue,
                          fontSize: 14.sp),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        jump(context, to: const CategoryPage());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.showAll,
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              SizedBox(
                height: 100.h,
                child: ListView.separated(
                  padding: EdgeInsetsDirectional.only(start: 14.w,end: 14.w),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            jump(context, to: const CategoryItemScreen());
                          },
                          child: Container(
                            width: 70.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(10.r),
                              border: Border.all(color: greyColor, width: 0.9.w),
                              color: Colors.grey.shade200,
                            ),
                            child: appCacheImg(
                              categoryItems[index].img!.link!,
                              Container(
                                width: 70.h,
                                height: 100.h,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${categoryItems[index].title}',
                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 9.sp,
                          ),
                          maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 6.w),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
