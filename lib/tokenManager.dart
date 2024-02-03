import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager{

  final storage = new FlutterSecureStorage();

  deleteToken(String tokenKey) async {
    await storage.delete(key: tokenKey);
  }

  Future<String?> readToken(String tokenKey) async {
    return await storage.read(key: tokenKey);
  }

  saveToken(String tokenKey, String token) async {
    await storage.write(key: tokenKey, value: token);
  }
}