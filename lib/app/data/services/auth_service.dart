import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/database_service.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  static const _userIdKey = 'current_user_id';
  static const _sessionKey = 'is_logged_in';

  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final DatabaseService _databaseService = Get.find<DatabaseService>();

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_sessionKey) ?? false;
    if (!loggedIn) return;
    final userId = prefs.getString(_userIdKey);
    if (userId == null || userId.isEmpty) return;
    currentUser.value = await _databaseService.getUserById(userId);
  }

  Future<bool> login({
    required String phone,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final isValid = await _databaseService.validateUserCredentials(
      phoneOrEmail: phone,
      password: password,
    );
    if (!isValid) {
      return false;
    }
    final user = await _databaseService.findUserByPhoneOrEmail(phone);
    if (user == null) return false;
    currentUser.value = user;
    await prefs.setBool(_sessionKey, true);
    await prefs.setString(_userIdKey, user.id);
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (password.length < 6) return false;
    final exists = await _databaseService.userExistsByPhoneOrEmail(phone, email);
    if (exists) return false;

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      phone: phone,
      email: email,
    );
    await _databaseService.insertUser(user: user, password: password);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionKey, false);
    await prefs.remove(_userIdKey);
    currentUser.value = null;
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sessionKey, false);
    await prefs.remove(_userIdKey);
    currentUser.value = null;
  }

  bool get isLoggedIn => currentUser.value != null;
}
