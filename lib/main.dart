// lib/main.dart
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart'; // nur für Desktop → optionale Handy-Größe

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
      color: Colors.black,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        // platform: TargetPlatform.android,  // ← meist nicht nötig → entfernen oder nur bei Bedarf
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2), // z. B. ein Blau-Ton – passe an dein Branding an
          brightness: Brightness.light,       // oder .dark
        ),
        // scaffoldBackgroundColor: Colors.white, // optional
      ),
      home: const IntroScreen(), // ← Start mit dem Lade-/Splash-Screen
    );
  }
}