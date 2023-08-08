import '../../Providers/language_provider.dart';
import '../../Widgets/My_Widgets/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../enums.dart';

class AppSettingPge extends StatefulWidget {
  const AppSettingPge({super.key});

  @override
  State<AppSettingPge> createState() => _AppSettingPgeState();
}

class _AppSettingPgeState extends State<AppSettingPge> {
  late String? radioValue =
      Provider.of<LanguageProvider>(context, listen: false).language;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, language, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.4,
            backgroundColor: whiteColor,
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
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.appSettings,
              style: textAppBarStyle,
            ),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 14.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ///App Language
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
                              SizedBox(height: 20.h),

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
                                  SizedBox(width: 15.w),
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
                              SizedBox(height: 10.h),
                              Divider(
                                color: greyColor,
                                height: 0.3.h,
                              ),

                              ///Items
                              InkWell(
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor: darkBlue,
                                      value: AppLanguages.ar.name,
                                      groupValue: radioValue,
                                      onChanged: (value) async {
                                        setState(() => radioValue = value);
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        await language
                                            .changeLanguage(AppLanguages.ar);
                                      },
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      'العربية',
                                      style: TextStyle(
                                        fontFamily: 'NotoKufiArabic',
                                        fontSize: 14.sp,
                                        color: darkBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: darkBlue,
                                    value: AppLanguages.en.name,
                                    groupValue: radioValue,
                                    onChanged: (value) async {
                                      setState(() => radioValue = value);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                      await language
                                          .changeLanguage(AppLanguages.en);
                                    },
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      fontFamily: 'TitilliumWeb',
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
