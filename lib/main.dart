// lib/main.dart
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart'; // nur für Desktop → optionale Handy-Größe
import 'package:google_fonts/google_fonts.dart';

// Deine Screens importieren
import 'package:hanse_fit_app/ui/main_scaffold.dart';
import 'package:hanse_fit_app/screens/intro_screen.dart';
import 'package:hanse_fit_app/screens/splash_screen.dart'; // ← neuen Splash-Screen importieren

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Nur für Desktop: simuliert Handy-Größe (optional – kannst du später entfernen)
  setWindowMinSize(const Size(420, 844));
  setWindowMaxSize(const Size(420, 844));
  setWindowTitle("Hanse Fit");

  runApp(const HanseFitApp());
}


class HanseFitApp extends StatelessWidget {
  const HanseFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hanse Fit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark, // Stellt sicher, dass die App im Dark Mode startet
        scaffoldBackgroundColor: const Color(0xFF121217), // Das dunkle Anthrazit aus deinem Bild
        
        // --- HIER WIRD DIE SCHRIFT GLOBAL EINGEFÜGT ---
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        // ----------------------------------------------

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5889FF), // Das Blau aus dem ersten Screenshot
          brightness: Brightness.dark,
        ),
      ),
      home: const IntroScreen(),
    );
  }
}