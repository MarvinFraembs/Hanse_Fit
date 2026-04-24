import 'package:shared_preferences/shared_preferences.dart';

const List<String> allowedStudios = [
  'FITNESSLAND Braunschweig Rebenpark',
  'FITNESSLAND Braunschweig Wilhelmstraße',
  'FITNESSLAND Braunschweig Celler Straße',
  'Hygia Braunschweig',
  'Floßstation - Bootsverleih am Botanischen Garten'
];

class AppPreferences {
  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  static Future<String> getMitgliedsId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('mitgliedsId') ?? '';
  }

  static Future<String> getArbeitgeber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('arbeitgeber') ?? '';
  }

  static Future<String?> getProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profileImagePath');
  }

  static Future<String> getStudio() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('studio') ?? '';
    // Optional: Falls ein ungültiger Wert gespeichert wurde → fallback
    return allowedStudios.contains(value) ? value : '';
  }

  static Future<void> setStudio(String value) async {
    if (!allowedStudios.contains(value) && value.isNotEmpty) {
      // Sicherheitsnetz – in Produktion ggf. loggen oder Exception werfen
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('studio', value);
  }
}