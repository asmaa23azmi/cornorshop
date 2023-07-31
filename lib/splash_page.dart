import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Helper/navigator_helper.dart';
import 'Screens/Admin_Screens/bnb/main_admin_page.dart';
import 'Screens/Bnb_Screens/main_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NavigatorHelper {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
    // jump(context, to: const MainPage(), replace: true);
     jump(context, to: const MainAdminPage(), replace: true);

    });

    super.initState();
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
