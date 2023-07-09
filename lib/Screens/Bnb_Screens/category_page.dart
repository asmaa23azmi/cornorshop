import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/category_model.dart';
import '../../Screens/Category_item_Screens/clothes_screen.dart';
import '../../Screens/Category_item_Screens/food_screen.dart';
import '../../Screens/Category_item_Screens/natural_product_screen.dart';
import '../../Screens/Category_item_Screens/hand_crafts_screen.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with NavigatorHelper{

   late AppLocalizations appLocale = AppLocalizations.of(context)!;
    List<CategoryModel> categoryItems =[
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
    return SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w , vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(AppLocalizations.of(context)!.categoryBar ,style: bnbTitlestyle,),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  onTap: (){},
                    child: Text(AppLocalizations.of(context)!.showAll, style: textStyle,)),
              ],),
              SizedBox(height: 25.h,),
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
                       onTap: (){
                       },
                       child: Row(
                         children: [
                           Container(
                             height: 60.h,
                             width: 60.h,
                             clipBehavior: Clip.antiAlias,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadiusDirectional.all(Radius.circular(4.r)),
                               border: Border.all(
                                 color: babyBlue,
                                 width: 1.w,
                               ),
                             ),
                             child: SvgPicture.asset('assets/images/${categoryItems[index].categoryImg}.svg',fit: BoxFit.cover),
                           ),
                           SizedBox(width: 9.w,),
                           Text(categoryItems[index].categoryTitle, style:textStyle ,),
                           const Spacer(//to position the widget in the end of the row
                           ),
                           Icon(Icons.arrow_back_ios_new,
                             color: darkBlue,
                             size: 15.w,),

                         ],
                       ),
                     );
                   },
                 separatorBuilder: (context, index) {
                    return Column(
                       children: [
                              SizedBox(height: 15.h,),
                              Divider(color: grayColor, height: 0.3.h,),
                              SizedBox(height: 15.h,),

                       ],
                );
               },
               ),
             )
            ],
          ),
        ),
    );
  }
}
// categoryItems[index] == 0
// ? jump(context, to: const ClothesScreen())
//     : categoryItems[index] == 1
// ? jump(context, to: const NaturalProductScreen())
//     : categoryItems [index] == 2
// ? jump(context, to: const FoodScreen())
//     : jump(context, to: const HandCraftsScreen());