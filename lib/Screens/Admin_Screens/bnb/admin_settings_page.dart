import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:cornorshop/Providers/language_provider.dart';

import '../../../Chache/cache_controller.dart';
import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Fierbase/controllers/fb_auth_controller.dart';
import '../../../Helper/navigator_helper.dart';
import '../../../Providers/auth_provider.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../enums.dart';
import '../../../Widgets/My_Widgets/my_list_tile.dart';
import '../../../splash_page.dart';

class AdminSettingPge extends StatefulWidget {
  const AdminSettingPge({super.key});

  @override
  State<AdminSettingPge> createState() => _AdminSettingPgeState();
}

class _AdminSettingPgeState extends State<AdminSettingPge> with NavigatorHelper{
  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

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
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: greyColor,
                                height: 0.3.h,
                              ),

                              ///Items
                              Row(
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
                                  SizedBox(
                                    width: 3.w,
                                  ),
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
                MyListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(14.r),
                          ),
                          child: Container(
                            width: 234.w,
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ///Paragraph
                                Text(
                                  AppLocalizations.of(context)!.logoutParagraph,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: darkBlue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                ///Logout Action
                                MyButton(
                                  onTap: () async{
                                    Navigator.pop(context);
                                    await FbAuthController().logout();
                                    _auth.logout;
                                    if(context.mounted){
                                    //  jump(context, to: const SplashPage(), replace: true);
                                    }
                                  },
                                  text: AppLocalizations.of(context)!.logout,
                                  buttonColor: greenColor,
                                  myWidth: 135,
                                  myHeight: 38,
                                  myFontSize: 12,
                                ),
                                SizedBox(height: 16.h),

                                ///Cancel
                                MyButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  text: AppLocalizations.of(context)!.cancel,
                                  buttonColor: Colors.transparent,
                                  myWidth: 135,
                                  myHeight: 38,
                                  myFontSize: 12,
                                  borderBouttonColor: greenColor,
                                  textButtonColor: greenColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: AppLocalizations.of(context)!.logout,
                  icon: Icons.logout,
                  color: Colors.red,
                )
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
