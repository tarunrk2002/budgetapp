import 'dart:core';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Cred_store{
  // Create storage

  static const _storage = FlutterSecureStorage();
  static final _key = "Email";
  static Future setUserName(String userName) async {
    await _storage.write(key: _key, value: userName);
  }
  static Future<String?> getUserName() async =>
     await _storage.read(key: _key);

  static Future LogoutUser() async{
    await _storage.delete(key: _key);
    await _storage.write(key: _key, value: "");
  }
//
// // Read all values
//   Map<String, String> allValues = await storage.readAll();
//
// // Delete value
//   await storage.delete(key: key);
//
// // Delete all
//   await storage.deleteAll();
//
// // Write value

}