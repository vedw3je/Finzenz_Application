import 'package:finzenz_app/modules/home/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static const _keyId = 'id';
  static const _keyFullName = 'fullName';
  static const _keyEmail = 'email';
  static const _keyPhone = 'phone';
  static const _keyAddress = 'address';
  static const _keyGender = 'gender';
  static const _keyDateOfBirth = 'dateOfBirth';
  static const _keyKycVerified = 'kycVerified';
  static const _keyActive = 'active';
  static const _keyIsLoggedIn = 'isLoggedIn';

  /// Save user to SharedPreferences
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyId, user.id);
    await prefs.setString(_keyFullName, user.fullName);
    await prefs.setString(_keyEmail, user.email);
    await prefs.setString(_keyPhone, user.phone);
    await prefs.setString(_keyAddress, user.address);
    await prefs.setString(_keyGender, user.gender);
    await prefs.setString(_keyDateOfBirth, user.dateOfBirth.toIso8601String());
    await prefs.setBool(_keyKycVerified, user.kycVerified);
    await prefs.setBool(_keyActive, user.active);

    // Mark as logged in
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  /// Get user from SharedPreferences
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_keyId)) return null; // No user saved

    return User(
      id: prefs.getInt(_keyId) ?? 0,
      fullName: prefs.getString(_keyFullName) ?? '',
      email: prefs.getString(_keyEmail) ?? '',
      phone: prefs.getString(_keyPhone) ?? '',
      address: prefs.getString(_keyAddress) ?? '',
      gender: prefs.getString(_keyGender) ?? '',
      dateOfBirth:
          DateTime.tryParse(
            prefs.getString(_keyDateOfBirth) ??
                DateTime.now().toIso8601String(),
          ) ??
          DateTime.now(),
      kycVerified: prefs.getBool(_keyKycVerified) ?? false,
      active: prefs.getBool(_keyActive) ?? false,
    );
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Clear saved user data (for logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyId);
    await prefs.remove(_keyFullName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPhone);
    await prefs.remove(_keyAddress);
    await prefs.remove(_keyGender);
    await prefs.remove(_keyDateOfBirth);
    await prefs.remove(_keyKycVerified);
    await prefs.remove(_keyActive);
    await prefs.remove(_keyIsLoggedIn); // Reset login state
  }
}
