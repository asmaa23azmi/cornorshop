import 'package:cornorshop/Providers/auth_provider.dart';
import 'package:cornorshop/Providers/style_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../Chache/cache_controller.dart';
import '../../Const/colors.dart';
import '../../Providers/language_provider.dart';
import 'enums.dart';
import 'splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Cache
  await CacheController().initCache();

  ///data base
  ///firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => LanguageProvider()),
                ChangeNotifierProvider(create: (_) => AuthProvider()),
                ChangeNotifierProvider(create: (_) => StyleProvider()),
              ],
              child: const MyMaterialApp(),
            );
          },
        );
      },
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, lang, child) {
        return MaterialApp(
          title: 'Corner Shop',
          debugShowCheckedModeBanner: false,

          ///delete debug sign
          theme: ThemeData(
            fontFamily: lang.language == AppLanguages.ar.name
                ? 'NotoKufiArabic'
                : 'TitilliumWeb',
            scaffoldBackgroundColor: whiteColor,
          ),
          home: const SplashPage(),

          ///for translation
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          locale: Locale(lang.language),

          ///to make arabic tha main language of the app
          supportedLocales:
              AppLanguages.values.map((e) => Locale(e.name)).toList(),
        );
      },
    );
  }
}
