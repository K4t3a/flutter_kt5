import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  static const _keyLoggedIn = 'loggedIn';
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';
  static const _keyEmail = 'email';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFirstName, user.firstName);
    await prefs.setString(_keyLastName, user.lastName);
    await prefs.setString(_keyEmail, user.email);
    await prefs.setBool(_keyLoggedIn, true);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(_keyLoggedIn) ?? false)) return null;

    return User(
      firstName: prefs.getString(_keyFirstName) ?? '',
      lastName: prefs.getString(_keyLastName) ?? '',
      email: prefs.getString(_keyEmail) ?? '',
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }
}
