import 'dart:convert';

import 'package:crypto/crypto.dart';

mixin HashMapHelper{
  ///To Hash Password
  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert the password to bytes
    var digest = sha256.convert(bytes); // Apply SHA-256 hash algorithm

    return digest.toString(); // Convert the hash to a string
  }
}