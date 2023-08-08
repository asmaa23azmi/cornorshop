import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/fb/category_model.dart';
import '../../Fierbase/controllers/categories_fb_controller.dart';
import '../../Screens/Category_item_Screens/item_category_screen.dart';

class CategoryHomeSection extends StatefulWidget {
  const CategoryHomeSection({
    super.key,
  });

  @override
  State<CategoryHomeSection> createState() => _CategoryHomeSectionState();
}

class _CategoryHomeSectionState extends State<CategoryHomeSection>
    with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: StreamBuilder(
        stream: CategoriesFbController().readCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<CategoryModel> categoryItems =
                snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.separated(
              padding: EdgeInsetsDirectional.only(start: 14.w),
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
                        width: 74.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(10.r),
                          border: Border.all(color: greyColor, width: 0.9.w),
                          color: Colors.grey.shade200,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '${categoryItems[index].img!.link}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${categoryItems[index].title}',
                      style: TextStyle(
                        color: darkBlue,
                        fontSize: 7.sp,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 6.w),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
