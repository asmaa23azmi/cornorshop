import 'package:cornorshop/Widgets/my_dropdown_search.dart';
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

  String? selectedItem;

  List<String> items = [
    'ملابس',
    'منتجات طبيعية',
    'طعام وحلويات منزلية',
    'مشغولات يدوية',
  ];

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
        elevation: 0.4,
        backgroundColor: whiteColor,
        //  toolbarHeight: 94.h,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: darkBlue,
            size: 22.h,
          ),
        ),
        title: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            AppLocalizations.of(context)!.search,
            style: textAppBarStyle,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: searchController,
                      hintText: AppLocalizations.of(context)!.searchBar,
                      outoFouce: true,
                      textFieldColor: Colors.transparent,
                      hintSyleColor: blackObacityColor,
                      textFieldBorderColor: blackObacityColor,
                      prefixIcon: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.search,
                          color: blackObacityColor,
                        ),
                        color: greyColor,
                        iconSize: 25.35.h,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      ///Bottom Sheet
                      _filteringBottomSheet(context);
                    },
                    child: Container(
                      height: 44.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadiusDirectional.circular(12.r),
                        border: Border.all(color: blackObacityColor),
                      ),
                      child: Icon(
                        Icons.filter_alt_rounded,
                        color: blackObacityColor,
                        size: 24.h,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsetsDirectional.symmetric(vertical: 15.h),
                  child: Column(
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
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _filteringBottomSheet(BuildContext context) {
    return showModalBottomSheet(
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
                                        MediaQuery.of(context).size.width *
                                            0.4,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.015),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(2.r),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .productFiltering,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0.sp,
                                  color: darkBlue,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: greyColor,
                                height: 0.3.h,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.only(start: 15.w),
                                child: Text(
                                  AppLocalizations.of(context)!.priceRange,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),

                              ///Determine the Price Range
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MyTextField(
                                    controller: lowerPriceController,
                                    hintText: AppLocalizations.of(context)!
                                        .lowestPrice,
                                    textFieldColor: Colors.transparent,
                                    hintSyleColor: blackObacityColor,
                                    textFieldBorderColor: blackObacityColor,
                                    textFieldWidth: 115,
                                    textFieldHeigth: 38,
                                    myFontSize: 12,
                                    inputType: TextInputType.number,
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
                                    hintText: AppLocalizations.of(context)!
                                        .topPrice,
                                    textFieldColor: Colors.transparent,
                                    hintSyleColor: blackObacityColor,
                                    textFieldBorderColor: blackObacityColor,
                                    textFieldWidth: 115,
                                    textFieldHeigth: 38,
                                    myFontSize: 12,
                                    inputType: TextInputType.number,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),

                              ///Choose Category
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.only(start: 15.w),
                                child: Text(
                                  AppLocalizations.of(context)!.categoryBar,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              MyDropdownSearch(
                                items: items,
                                onChange: (value) => selectedItem = value,
                              ),
                              SizedBox(
                                height: 26.h,
                              ),

                              ///Actions
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MyButton(
                                      onTap: () {},
                                      text:
                                          AppLocalizations.of(context)!.apply,
                                      myWidth: 130,
                                      myHeight: 38,
                                      myFontSize: 12,
                                      borderBouttonColor: Colors.transparent,
                                      buttonColor: greenColor),
                                  MyButton(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      text: AppLocalizations.of(context)!
                                          .cancel,
                                      myWidth: 130,
                                      myHeight: 38,
                                      myFontSize: 12,
                                      borderBouttonColor: greenColor,
                                      buttonColor: Colors.transparent,
                                      textButtonColor: greenColor),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
  }
}
