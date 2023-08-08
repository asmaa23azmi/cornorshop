import '../../Fierbase/controllers/categories_fb_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

class _CategoryPageState extends State<CategoryPage> with NavigatorHelper {
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
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    List<CategoryModel> categoryItems =
                        snapshot.data!.docs.map((e) => e.data()!).toList();
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
                                      border: Border.all(
                                          color: greenColor, width: 1.w)),
                                  child: CachedNetworkImage(
                                      imageUrl:
                                          '${categoryItems[index].img!.link}',
                                      fit: BoxFit.cover)),
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
                    return const SizedBox();
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
