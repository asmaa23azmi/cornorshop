import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Admin name
                      Text('اسم الأدمن', style: textStyle),
                      ///Admin
                      Text(
                        'email address or phone num',
                        style: TextStyle(
                          fontFamily: 'TitilliumWeb',
                          color: blackObacityColor,
                          fontSize: 13.sp
                        ),
                      ),
                      ///Admin Type
                      Text(
                        'ex. Super Admin',
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
  }
}
