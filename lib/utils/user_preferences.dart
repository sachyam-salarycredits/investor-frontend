import 'package:shared_preferences/shared_preferences.dart';

// class UserPreference {
//   static UserPreference shared = UserPreference();
//
//   /// Preference keys
//   final String customerId = "customerId";
//   final String isLoggedIn = "isLoggedIn";
//
//   /// Get CustomerId
//   Future<String?> getCid() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(this.customerId) ?? null;
//   }
//
//   /// Save CustomerId
//   Future<void> saveCid(String? cid) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (cid != null) {
//       prefs.setString(this.customerId, cid);
//     } else {
//       prefs.remove(this.customerId);
//     }
//   }
//
//   /// Clear user Data
//   Future<void> clearUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }
// }
