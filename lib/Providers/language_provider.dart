import 'package:flutter/material.dart';
import '../../Chache/cache_controller.dart';
import '../enums.dart';

class LanguageProvider extends ChangeNotifier {
  String language =
      CacheController().getter(CacheKeys.language) ?? AppLanguages.ar.name;

  Future<void> changeLanguage(AppLanguages lang) async {
    language = lang.name;
    await CacheController().setter(CacheKeys.language, language);
    notifyListeners();
  }
// Future<void> switchLanguage() async {
//   language = language == AppLanguages.ar.name
//       ? AppLanguages.en.name
//       : AppLanguages.ar.name;
//   await CacheController().setter(CacheKeys.language, language);
//   notifyListeners();
// }
}
