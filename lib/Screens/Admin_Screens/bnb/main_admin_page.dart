import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Const/colors.dart';
import '../../../Helper/navigator_helper.dart';
import '../bnb/admin_dashboard_page.dart';
import '../bnb/admin_manage_page.dart';
import '../bnb/admin_settings_page.dart';

class MainAdminPage extends StatefulWidget {
  const MainAdminPage({super.key});

  @override
  State<MainAdminPage> createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> with NavigatorHelper {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          ///List from pages with index to move from page to other selected one.
          [
        const AdminDashboardPage(),
        const AdminManagingPage(),
        const AdminSettingPge(),
      ][selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 60.h,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,

          /// the index for the page that where iam now.
          onTap: (int index) => setState(() => selectedIndex = index),

          ///call_back, that return the index value that i pressed on it ==> (){}.
          ///setState() its important method ==> used to move between pages and make refresh for the page.
          showSelectedLabels: true,

          /// to show the text(label) under the icon default value: true.
          backgroundColor: whiteColor,
          /// to remove border
          iconSize: 28.h,
          selectedItemColor: greenColor,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: TextStyle(
            fontSize: 8.0.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 8.0.sp,
          ),
          type: BottomNavigationBarType.fixed,

          /// to show all icons cause we have > 4 icons
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_rounded),
              label: AppLocalizations.of(context)!.adminDashboard,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.analytics),
              label: AppLocalizations.of(context)!.adminInfoManaging,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.appSettings,
            ),
          ],
        ),
      ),
    );
  }
}
