import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/texts.dart';
import '../../Const/colors.dart';
import '../../Widgets/My_Widgets/my_profile_settings.dart';
import '../../Providers/auth_provider.dart';

class BuyerProfilePage extends StatefulWidget {
  const BuyerProfilePage({super.key});

  @override
  State<BuyerProfilePage> createState() => _BuyerProfilePageState();
}

class _BuyerProfilePageState extends State<BuyerProfilePage>
    with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: whiteColor,
          //toolbarHeight: 100.h,
          title: Text(
            AppLocalizations.of(context)!.userPage,
            style: textAppBarStyle,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 35.w, vertical: 35.h),
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                ///profile img
                Center(
                  child: Container(
                    height: 120.h,
                    width: 120.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60.h,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                ///user name
                Center(
                  child: Text(
                    auth.user?.name ?? '',
                    style: textStyle,
                  ),
                ),

                SizedBox(height: 40.h),

                ///settings
                const MyProfileSettings(),
                SizedBox(height: 14.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
