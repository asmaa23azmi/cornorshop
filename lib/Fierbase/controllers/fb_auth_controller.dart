import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Helper/snack_bar_helper.dart';
import 'package:flutter/material.dart';

class FbAuthController with SnackBarHelper{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> register(
      BuildContext context, {required String email, required String password}) async {
    try {
      var data = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return data;
    }on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        showMySnackBar(context, text: AppLocalizations.of(context)!.invalidEmail, error: true);
      } else if (error.code == 'email-already-in-use') {
        showMySnackBar(context, text: AppLocalizations.of(context)!.emailUsed, error: true);
      } else if (error.code == 'weak-password') {
        showMySnackBar(context, text: AppLocalizations.of(context)!.weakPassword, error: true);
      }else {
        showMySnackBar(context,
            text: AppLocalizations.of(context)!.errorMsg, error: true);
      }
    }  catch (e) {
      return null;
    }
    return null;
  }

  Future<UserCredential?> login(
  BuildContext context, {required String email, required String password}) async {
    try {
      var data = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return data;
    } on FirebaseAuthException catch (error) {
      // if (error.code == 'invalid-email') {
      //   showMySnackBar(context, text: AppLocalizations.of(context)!.invalidEmail, error: true);
      // } else
        if (error.code == 'wrong-password') {
        showMySnackBar(context, text: AppLocalizations.of(context)!.wrongPassword, error: true);
      } else if (error.code == 'user-not-found') {
        showMySnackBar(context, text: AppLocalizations.of(context)!.userNotFound, error: true);
      } else if (error.code == 'user-disabled') {
        showMySnackBar(context, text: AppLocalizations.of(context)!.userDisabled, error: true);
      }else {
        showMySnackBar(context,
            text: AppLocalizations.of(context)!.errorMsg, error: true);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }


Future<void> deleteAccount(String id) async{
  try{
    User? user = _auth.currentUser;

    if (user != null) {
      // Delete the user's authentication account
      await user.delete();
      print("User account and data deleted successfully.");
    } else {
      print("No user is currently logged in.");
    }
  }catch(e){
    print("Error deleting user: $e");
  }
}
}
