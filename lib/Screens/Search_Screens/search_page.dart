import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/my_button.dart';
import '../../Widgets/my_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  late TextEditingController lowerPriceController;
  late TextEditingController topPriceController;

  @override
  void initState() {
    searchController = TextEditingController();
    lowerPriceController = TextEditingController();
    topPriceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    lowerPriceController.dispose();
    topPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: babyBlue,
        toolbarHeight: 124.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(20.r),
              bottomStart: Radius.circular(20.r)),
        ),
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 24.0.h,
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsetsDirectional.only(
            end: 15.w,
            top: 15.h,
          ),
          child: MyTextField(
            controller: searchController,
            hintText: AppLocalizations.of(context)!.searchBar,
            prefixIcon: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: const Icon(
                Icons.search,
              ),
              color: grayColor,
              iconSize: 25.35.h,
              onPressed: () {},
            ),
          ),
        ),
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20.r),
                        topEnd: Radius.circular(20.r))),
                builder: (context) {
                  return Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 26.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Black Divider
                        Container(
                          height: 4,
                          margin: EdgeInsetsDirectional.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.4,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.015),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadiusDirectional.circular(2.r),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          AppLocalizations.of(context)!.priceRange,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),

                        ///Determine the Price Range
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyTextField(
                              controller: lowerPriceController,
                              hintText:
                                  AppLocalizations.of(context)!.lowestPrice,
                              textFieldColor: Colors.transparent,
                              hintSyleColor: blackObacityColor,
                              textFieldBorderColor: blackObacityColor,
                              textFieldWidth: 115.w,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              AppLocalizations.of(context)!.to,
                              style: textStyle,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            MyTextField(
                              controller: topPriceController,
                              hintText: AppLocalizations.of(context)!.topPrice,
                              textFieldColor: Colors.transparent,
                              hintSyleColor: blackObacityColor,
                              textFieldBorderColor: blackObacityColor,
                              textFieldWidth: 115.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Divider(
                          color: grayColor,
                          height: 0.3.h,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),

                        ///Choose Category
                        Text(
                          AppLocalizations.of(context)!.categoryBar,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),

                        ///Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyButton(
                                onTap: () {},
                                text: AppLocalizations.of(context)!.apply,
                                myWidth: 135.w,
                                borderBouttonColor: Colors.transparent,
                                buttonColor: orangeColor),
                            MyButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                text: AppLocalizations.of(context)!.cancel,
                                myWidth: 135.w,
                                borderBouttonColor: orangeColor,
                                buttonColor: Colors.transparent,
                                textButtonColor: orangeColor),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              // padding: EdgeInsetsDirectional.only(end: 20.w),
              margin: EdgeInsetsDirectional.only(
                  end: 20.w, top: 50.h, bottom: 40.h),
              height: 44.h,
              width: 36.w,
              decoration: BoxDecoration(
                color: darkBlue,
                borderRadius: BorderRadiusDirectional.circular(12.r),
              ),
              child: Icon(
                Icons.filter_alt_rounded,
                color: whiteColor,
                size: 25.h,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: 20.w, vertical: 160.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/search.png',
                height: 160.h,
                width: 160.h,
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                textAlign: TextAlign.center,
                maxLines: 2,
                AppLocalizations.of(context)!.paragraphSearch,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10.sp,
                  color: darkBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
