import '../../../Providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: whiteColor,
          title: Text(
            AppLocalizations.of(context)!.adminDashboard,
            style: textAppBarStyle,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
            EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ///Profile Img
                    Container(
                      width: 80.w,
                      height: 80.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60.h,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(width:15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///Admin name
                        Text(auth.user?.name ?? ''
                        , style: textStyle),
                        ///Admin Email
                        Text(
                          auth.user?.email ?? '',
                          style: TextStyle(
                              fontFamily: 'TitilliumWeb',
                              color: blackObacityColor,
                              fontSize: 13.sp
                          ),
                        ),
                        ///Admin Type
                        Text(
                          auth.user?.userType ?? '',
                          style: TextStyle(
                              fontFamily: 'TitilliumWeb',
                              color: blackObacityColor,
                              fontSize: 13.sp
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}
