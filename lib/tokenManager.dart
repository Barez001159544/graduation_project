import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager{
  Future<Future<String?>> returnedToken() async{
    return readToken();
  }

  String _tokenKey='accessToken';
  final storage = new FlutterSecureStorage();

  @override
  deleteToken() async {
    await storage.delete(key: _tokenKey);
  }

  @override
  Future<String?> readToken() async {
    return await storage.read(key: _tokenKey);
  }

  @override
  saveToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }
}