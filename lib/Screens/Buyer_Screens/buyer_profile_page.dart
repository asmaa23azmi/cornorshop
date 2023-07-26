import 'package:cornorshop/Widgets/my_profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Helper/navigator_helper.dart';
import '../../Const/texts.dart';

class BuyerProfilePage extends StatefulWidget {
  const BuyerProfilePage({super.key});

  @override
  State<BuyerProfilePage> createState() => _BuyerProfilePageState();
}

class _BuyerProfilePageState extends State<BuyerProfilePage>
    with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 35.w, vertical: 35.h),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60.h,
                  width: 60.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 40.h,
                    color: Colors.grey.shade300,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  'اسم المستخدم ',
                  style: textStyle,
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            const MyProfileSettings(),
            SizedBox(
              height: 14.h,
            ),
          ],
        ),
      ),
    );
  }
}
