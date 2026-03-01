import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  static Future<String> getMitgliedsId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('mitgliedsId') ?? '';
  }

  static Future<String> getAktivitaet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('aktivitaet') ?? '';
  }
}