
import 'package:cornorshop/Screens/Category_item_Screens/item_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/category_model.dart';

class CategoryHomeSection extends StatefulWidget {
  
  final List<CategoryModel> categoryItems;

  const CategoryHomeSection({
    super.key,
    required this.categoryItems,
  });

  @override
  State<CategoryHomeSection> createState() => _CategoryHomeSectionState();
}

class _CategoryHomeSectionState extends State<CategoryHomeSection> with NavigatorHelper{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:100.h,
      child: ListView.separated(
        padding: EdgeInsetsDirectional.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {jump(context, to:const CategoryItemScreen());},
                child: Container(
                  // height: 70.h,
                  width: 74.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadiusDirectional.circular(10.r),
                    color: Colors.grey.shade200,
                  ),
                  child: Image.asset(
                      'assets/images/${widget.categoryItems[index].categoryImg}.png',
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                widget.categoryItems[index].categoryTitle,
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 7.sp,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 20.w),
      ),
    );
  }
}
