import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // Define keys for storage
  static const String _userNameKey = "USERNAMEKEY";
  static const String _userEmailKey = "USEREMAILKEY";
  static const String _userWalletKey = "USERWALLETKEY";
  static const String _userIdKey = "USERIDKEY";

  // --- Singleton Pattern ---
  // Static final field to hold the single instance
  static final SharedPreferenceHelper _instance = SharedPreferenceHelper._internal();

  // Factory constructor to return the single instance
  factory SharedPreferenceHelper() {
    return _instance;
  }

  // Private internal constructor
  SharedPreferenceHelper._internal();

  // --- SAVE METHODS ---

  Future<bool> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userNameKey, userName);
  }

  Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userEmailKey, userEmail);
  }

  Future<bool> saveUserWallet(String userWallet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userWalletKey, userWallet);
  }

  Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userIdKey, userId);
  }

  // --- GET METHODS ---

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  Future<String?> getUserWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userWalletKey);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // --- CLEAR/LOGOUT METHOD ---

  Future<bool> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // This will clear all data stored by your app
    return prefs.clear();
  }
}
