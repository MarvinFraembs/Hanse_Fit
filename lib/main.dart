// lib/main.dart
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart'; // optional für feste Handy-Größe
import 'package:hanse_fit_app/ui/main_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Nur für Desktop → kleines Handy-Fenster
  setWindowMinSize(const Size(390, 844));
  setWindowMaxSize(const Size(390, 844));
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
        platform: TargetPlatform.android,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MainScaffold(), // ← unser Wrapper mit Bottom-Bar
    );
  }
}