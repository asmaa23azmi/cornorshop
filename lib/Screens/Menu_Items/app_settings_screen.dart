import 'package:cornorshop/Providers/language_provider.dart';
import 'package:cornorshop/Widgets/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../enums.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  String? radioValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
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
            title: Text(
              AppLocalizations.of(context)!.appSettings,
              style: textAppBarStyle,
            ),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 20.w, vertical: 20.h),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                MyListTile(
                  onTap: () {
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
                            children: [
                              ///Black Divider
                              Container(
                                height: 4,
                                margin: EdgeInsetsDirectional.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * 0.4,
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

                              ///Title
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: darkBlue,
                                        size: 20.w,
                                      )),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.appLanguage,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0.sp,
                                      color: darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: grayColor,
                                height: 0.3.h,
                              ),

                              ///Items
                              Row(
                                children: [
                                  Radio(
                                    value: AppLanguages.ar.name,
                                    groupValue: radioValue,
                                    onChanged: (value) async{
                                      setState(() async{
                                        radioValue = value;
                                        await language.changeLanguage(AppLanguages.ar);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    'العربية',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: AppLanguages.en.name,
                                    groupValue: radioValue,
                                    onChanged: (value) async{
                                      setState(() async{
                                        radioValue = value;
                                        await language.changeLanguage(AppLanguages.en);

                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  text: AppLocalizations.of(context)!.appLanguage,
                  icon: Icons.language_rounded,
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
//   onTap: () async {
//     await language.changeLanguage();
//   },
//
