import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService extends GetxService {
  static const _userKey = 'current_user';
  static const _sessionKey = 'is_logged_in';
  static const _passwordKey = 'dummy_password';

  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_sessionKey) ?? false;
    if (!loggedIn) return;
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      currentUser.value = UserModel.fromJson(userJson);
    }
  }

  Future<bool> login({
    required String phone,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_userKey);
    final savedPassword = prefs.getString(_passwordKey);
    if (saved == null) return false;
    final user = UserModel.fromJson(saved);
    if (user.phone != phone || savedPassword != password) {
      return false;
    }
    currentUser.value = user;
    await prefs.setBool(_sessionKey, true);
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (password.length < 6) return false;
    final prefs = await SharedPreferences.getInstance();
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      phone: phone,
      email: email,
    );
    await prefs.setString(_userKey, user.toJson());
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_sessionKey, false);
    currentUser.value = null;
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionKey, false);
    currentUser.value = null;
  }

  bool get isLoggedIn => currentUser.value != null;
}
