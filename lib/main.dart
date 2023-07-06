import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'enums.dart';
import 'splash_page.dart';



void main() {
  ///data base
  ///firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(375, 812),
      builder: (context, child) {
     return MaterialApp(
        title: 'Corner Shop',
        debugShowCheckedModeBanner: false, ///delete debug sign
        theme: ThemeData(
          fontFamily: 'NotoKufiArabic',
        ),
      home: SplashPage(),
       ///for translation
        localizationsDelegates: AppLocalizations.localizationsDelegates,///for translation
        locale: const Locale('ar'), ///to make arabic tha main language of the app
        supportedLocales: AppLanguages.values.map((e) => Locale(e.name)).toList(),
      );
    },);
  }

}

