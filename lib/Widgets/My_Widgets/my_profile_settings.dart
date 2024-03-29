import 'package:cornorshop/Providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Screens/Auth/change_password.dart';
import '../My_Widgets/my_button.dart';
import 'my_list_item.dart';
import '../../Helper/navigator_helper.dart';
import '../../Fierbase/controllers/fb_auth_controller.dart';
import '../../enums.dart';

class MyProfileSettings extends StatefulWidget {
  const MyProfileSettings({super.key});

  @override
  State<MyProfileSettings> createState() => _MyProfileSettingsState();
}

class _MyProfileSettingsState extends State<MyProfileSettings>
    with NavigatorHelper {
  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Column(
          children: [
            ///Change Password
            MyListItem(
                onTap: () {
                  jump(context, to: const ChangePassword());
                },
                text: AppLocalizations.of(context)!.changePassword,
                icon: Icons.password_rounded,
                size: 21.w),
            SizedBox(height: 16.h),

            ///Request Delete Account
            MyListItem(
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
                              AppLocalizations.of(context)!
                                  .deleteAccountParagraphOne,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: darkBlue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.h),

                            ///Delete Account Action
                            MyButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                14.r),
                                      ),
                                      child: Container(
                                        width: 234.w,
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 20.w,
                                                vertical: 22.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .deleteAccountParagraphTwo,
                                              style: textStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 10.h),
                                            MyButton(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .ok,
                                              buttonColor: greenColor,
                                              myWidth: 135,
                                              myHeight: 38,
                                              myFontSize: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              text: AppLocalizations.of(context)!.deleteAccount,
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
              text: AppLocalizations.of(context)!.requestDeleteAccount,
              icon: Icons.person_remove_rounded,
              size: 21.w,
            ),
            SizedBox(height: 16.h),

            ///Logout
            MyListItem(
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
                                onTap: () async {
                                  Navigator.pop(context);
                                  if(auth.user?.userType == UserType.vendor.name){
                                    Navigator.pop(context);
                                  }
                                  await FbAuthController().logout();
                                  _auth.logout;
                                  if (context.mounted) {}
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
                icon: Icons.logout_rounded,
                size: 21.w),
          ],
        );
      },
    );
  }
}
