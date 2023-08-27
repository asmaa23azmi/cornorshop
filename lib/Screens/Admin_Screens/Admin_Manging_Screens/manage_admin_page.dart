import 'package:provider/provider.dart';

import '../../../Fierbase/controllers/user_fb_controller.dart';
import '../../../Helper/image_helper.dart';
import '../../../Models/fb/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Providers/auth_provider.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Helper/navigator_helper.dart';
import '../../../Screens/Admin_Screens/User_Screens/insert_user_page.dart';
import '../../../enums.dart';

class ManageAdminPage extends StatefulWidget {
  const ManageAdminPage({super.key});

  @override
  State<ManageAdminPage> createState() => _ManageAdminPageState();
}

class _ManageAdminPageState extends State<ManageAdminPage> with NavigatorHelper , ImgHelper{

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics:const BouncingScrollPhysics(),
        children: [
          ///Title
          Text(
            AppLocalizations.of(context)!.adminManaging,
            style: bnbTitlestyle,
          ),
          SizedBox(height: 10.h),
          ///Data
          StreamBuilder(
            stream: UserFbController().showAdmins(),
            builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 240.h),
                child: const Center(child: CircularProgressIndicator()),
              );
            }else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<UserModel> admin = snapshot.data!.docs.map((e) => e.data()).toList();
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.zero,
                shrinkWrap: true,
                itemCount: admin.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 6.w, vertical: 6.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(14.r),
                            border:
                            Border.all(color: Colors.grey.shade200, width: .8.w)),
                        child: Column(
                          children: [

                            ///admin name
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.adminName} : ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue),
                                ),
                                Text(
                                  admin[index].name ?? '',
                                  style: TextStyle(fontSize: 13.sp, color: darkBlue),
                                ),
                              ],
                            ),
                            ///admin phone num
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.phoneNum} : ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue),
                                ),
                                Text(
                                  admin[index].phoneNum ??'',
                                  style: TextStyle(fontSize: 13.sp, color: darkBlue),
                                ),
                              ],
                            ),
                            ///admin email
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.email} : ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue),
                                ),
                                Text(
                                  admin[index].email ?? '',
                                  style: TextStyle(fontSize: 13.sp, color: darkBlue),
                                ),
                              ],
                            ),
                            ///admin password
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.password} : ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue),
                                ),
                                Text(
                                  admin[index].password ?? '',
                                  style: TextStyle(fontSize: 13.sp, color: darkBlue),
                                ),
                              ],
                            ),
                            ///admin type
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.adminType} : ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue),
                                ),
                                Text(
                                  admin[index].userType ?? '',
                                  style: TextStyle(fontSize: 13.sp, color: darkBlue),
                                ),
                              ],
                            ),
                            ///admin img
                            Row(
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.adminImg} : ',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue),
                                ),
                                Container(
                                  height: 70.h,
                                  width: 70.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8.r)),
                                  child: appCacheImg(
                                    admin[index].profileImg?.link ?? '',
                                    Container(
                                      width: 70.h,
                                      height: 70.h,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PositionedDirectional(
                          top: 7.h,
                          end: 5.w,
                          child: Row(
                            children: [
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => _auth.user?.userType == UserType.superAdmin.name ? jump(context, to: InsertUserPage(user: admin[index])) : null,
                                child: const Icon(
                                  Icons.edit,
                                  color: greyColor,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  _auth.user?.userType == UserType.superAdmin.name? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadiusDirectional.circular(14.r),
                                        ),
                                        child: Container(
                                          width: 234.w,
                                          padding: EdgeInsetsDirectional.symmetric(
                                              horizontal: 20.w, vertical: 22.h),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .doYouWantToDeleteThisUser,
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: darkBlue,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .deleteUserParagraph,
                                                style: TextStyle(
                                                    fontSize: 10.sp, color: darkBlue),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 10.h),

                                              ///Delete Product Action
                                              MyButton(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  await UserFbController()
                                                      .deleteUser(
                                                      admin[index]);
                                                },
                                                text: AppLocalizations.of(context)!
                                                    .delete,
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
                                                text: AppLocalizations.of(context)!
                                                    .cancel,
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
                                  ): null;
                                },
                                child: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
              );
            }else{
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 240.h),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.theresNoAdminYet,
                    style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.normal,
                        color: blackObacityColor),
                  ),
                ),
              );
            }
          },)
        ],
      ),
    );
  }
}
