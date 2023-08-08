import 'package:firebase_auth/firebase_auth.dart';

class FbAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> register(
      {required String email, required String password}) async {
    try {
      var data = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return data;
    } catch (e) {
      return null;
    }
  }
}
