import 'package:cornorshop/Chache/cache_controller.dart';
import 'package:cornorshop/enums.dart';
import 'package:flutter/material.dart';
import '../../Models/fb/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;

  ///Functions
  UserModel? get user => _user;

  set user(UserModel? _) => [_user = _, notifyListeners()];

  bool loggedIn = CacheController().getter(CacheKeys.loggedIn) ?? false;
  //String userType = CacheController().getter(CacheKeys.userType) ?? '';

  Future<void> get login async {
    loggedIn = true;
    await CacheController().setter(CacheKeys.loggedIn, true);
    notifyListeners();
  }

  Future<void> get logout async {
    user = null;
    loggedIn = false;
    await CacheController().setter(CacheKeys.loggedIn, false);
    notifyListeners();
  }
}
