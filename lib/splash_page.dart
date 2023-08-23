import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Chache/cache_controller.dart';
import 'Fierbase/controllers/user_fb_controller.dart';
import 'Helper/navigator_helper.dart';
import 'Providers/auth_provider.dart';
import 'Screens/Admin_Screens/bnb/main_admin_page.dart';
import 'Screens/Bnb_Screens/main_page.dart';
import 'enums.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NavigatorHelper {
  @override
  void initState() {
    super.initState();
    init;
  }

  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  Future<void> get init async {
    if (_auth.loggedIn) {
      ///UserModel from FireStore
      var userModel = await UserFbController()
          .getUserInfo(CacheController().getter(CacheKeys.userId));

      if (userModel == null) throw Exception('FireStore Error');

      ///Provider
      if (context.mounted) {
        _auth.user = userModel;
      }
    }
    Future.delayed(const Duration(seconds: 3), () {
      jump(context, to: const MainPage(), replace: true);
       //jump(context, to: const MainAdminPage(), replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 100.w,
            height: 100.w,
          ),
        ),
      ),
    );
  }
}
