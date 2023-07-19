import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: whiteColor,
        //  toolbarHeight: 100.h,
          title: Padding(
            padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w),
            child: Text(
              AppLocalizations.of(context)!.myFavProduct,
              style: textAppBarStyle,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
      padding:
            EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   AppLocalizations.of(context)!.myFavProduct,
            //   style: bnbTitlestyle,
            // ),
            SizedBox(
              height: 18.h,
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.zero,
                shrinkWrap: true,
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 14, mainAxisSpacing: 14),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsetsDirectional.only(
                        start: 6.w, end: 6.w, bottom: 6.h),
                    width: 105.w,
                    height: 156.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(4.r)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
      ),
    ),
        ));
  }
}
