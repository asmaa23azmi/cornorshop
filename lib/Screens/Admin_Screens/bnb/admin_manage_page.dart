import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Const/colors.dart';
import '../../../Const/texts.dart';
import '../../../Screens/Admin_Screens/Category_Screens/manage_category_page.dart';
import '../../../Screens/Admin_Screens/Product_Screens/manage_product_page.dart';
import '../../../Screens/Admin_Screens/User_Screens/manage_user_page.dart';
import '../../../Screens/Admin_Screens/Admin_Manging_Screens/manage_admin_page.dart';

class AdminManagingPage extends StatefulWidget {
  const AdminManagingPage({super.key});

  @override
  State<AdminManagingPage> createState() => _AdminManagingPageState();
}

class _AdminManagingPageState extends State<AdminManagingPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        title: Text(
          AppLocalizations.of(context)!.adminInfoManaging,
          style: textAppBarStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
           physics:const BouncingScrollPhysics(),
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.categoryManaging,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: selectedIndex == 0
                            ? greenColor
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.userManaging,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: selectedIndex == 1
                            ? greenColor
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.productManaging,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: selectedIndex == 2
                            ? greenColor
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.adminManaging,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: selectedIndex == 3
                            ? greenColor
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              selectedIndex == 0
                  ? const ManageCategoryPage()
                  : selectedIndex == 1
                  ? const ManageUsersPage()
                  : selectedIndex == 2
                      ? const ManageProductPage()
                      : const ManageAdminPage()
            ],
          ),
        ),
      ),
    );
  }
}
