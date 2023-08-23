import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Fierbase/controllers/user_fb_controller.dart';
import '../../../Models/fb/user_model.dart';
import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Helper/navigator_helper.dart';
import '../../../Screens/Admin_Screens/User_Screens/insert_user_page.dart';
import '../../../Helper/image_helper.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage>
    with NavigatorHelper, ImgHelper {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.userManaging,
                style: bnbTitlestyle,
              ),
              const Spacer(),
              InkWell(
                onTap: () => jump(context, to: const InsertUserPage()),
                child: Icon(
                  Icons.add,
                  color: greenColor,
                  size: 30.h,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          StreamBuilder(
            stream: UserFbController().readUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 240.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<UserModel> users =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.zero,
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 6.w, vertical: 6.h),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(14.r),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: .8.w)),
                          child: Column(
                            children: [
                              ///user id
                              // Row(
                              //   children: [
                              //     Text(
                              //       'User Id : ',
                              //       style: TextStyle(
                              //           fontSize: 13.sp,
                              //           fontWeight: FontWeight.w600,
                              //           color: darkBlue,
                              //           fontFamily: 'TitilliumWeb'),
                              //     ),
                              //     Text(
                              //       '',
                              //       style:
                              //           TextStyle(fontSize: 13.sp, color: darkBlue),
                              //     ),
                              //   ],
                              // ),

                              ///user name
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.userName} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${users[index].name}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user phone num
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
                                    '${users[index].phoneNum}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user email
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
                                    '${users[index].email}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user address
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.address} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${users[index].address}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user password
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
                                    '${users[index].password}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user gender(sex)
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.userGender} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${users[index].sex}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user type(vendor, buyer, admin)
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.userType} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${users[index].userType}',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user timestamp
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.timestamp} : ',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkBlue),
                                  ),
                                  Text(
                                    '${users[index].timestamp!.toDate()}',
                                    //'',
                                    style: TextStyle(
                                        fontSize: 13.sp, color: darkBlue),
                                  ),
                                ],
                              ),

                              ///user img
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.userImg} : ',
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
                                      users[index].profileImg?.link ?? '',
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
                                  onTap: () => jump(context,
                                      to: InsertUserPage(
                                        user: users[index],
                                      )),
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
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(14.r),
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
                                                      .doYouWantToDeleteThisUser,
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: darkBlue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .deleteUserParagraph,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: darkBlue),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 10.h),

                                                ///Delete Product Action
                                                MyButton(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await UserFbController()
                                                        .deleteUser(
                                                            users[index]);
                                                  },
                                                  text: AppLocalizations.of(
                                                          context)!
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
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .cancel,
                                                  buttonColor:
                                                      Colors.transparent,
                                                  myWidth: 135,
                                                  myHeight: 38,
                                                  myFontSize: 12,
                                                  borderBouttonColor:
                                                      greenColor,
                                                  textButtonColor: greenColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
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
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 240.h),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.theresNoUsersYet,
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.normal,
                          color: blackObacityColor),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
