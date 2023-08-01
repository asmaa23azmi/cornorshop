import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Widgets/My_Widgets/my_button.dart';
import '../../../Helper/navigator_helper.dart';
import '../../../Screens/Admin_Screens/User_Screens/insert_user_page.dart';

class ManageAdminPage extends StatefulWidget {
  const ManageAdminPage({super.key});

  @override
  State<ManageAdminPage> createState() => _ManageAdminPageState();
}

class _ManageAdminPageState extends State<ManageAdminPage> with NavigatorHelper{


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        physics:const BouncingScrollPhysics(),
        children: [
          ///Title
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.adminManaging,
                style: bnbTitlestyle,
              ),
              const Spacer(),
               InkWell(
                 onTap: () => jump(context, to:const InsertUserPage()),
                 child: Icon(
                  Icons.add,
                  color: greenColor,
                  size: 30.h,
              ),
               )
            ],
          ),
          SizedBox(height: 10.h),
          ///Data
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            shrinkWrap: true,
            itemCount: 4,
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
                        /// admin id
                        Row(
                          children: [
                            Text(
                              'Admin Id : ',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: darkBlue,
                                  fontFamily: 'TitilliumWeb'),
                            ),
                            Text(
                             '',
                              style: TextStyle(fontSize: 13.sp, color: darkBlue),
                            ),
                          ],
                        ),
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
                              '',
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
                              '',
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
                              '',
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
                             '',
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
                            '',
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
                            Text(
                              '',
                              style: TextStyle(fontSize: 13.sp, color: darkBlue),
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
                            onTap: () => jump(context, to:const InsertUserPage()),
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
                                            onTap: () {
                                              Navigator.pop(context);
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
          )
        ],
      ),
    );
  }
}
