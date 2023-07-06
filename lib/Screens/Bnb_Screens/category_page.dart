import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/texts.dart';
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w , vertical: 20.h),
          child: Column(
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
            ],
          ),
        ),
    );
  }
}
