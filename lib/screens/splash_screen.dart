import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hanse_fit_app/ui/main_scaffold.dart'; // Pfad anpassen!

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndNavigate();
    });
  }

  Future<void> _initializeAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainScaffold(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Oberer Teil: nur das Hintergrundbild (füllt den verfügbaren Raum)
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Hanse_Fit_Loading_Page.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Unterer blauer Kasten – volle Breite, feste Höhe
          Container(
            width: double.infinity,
            height: 120,                    // ← Höhe anpassen: 80–160 je nach Wunsch
            color: const Color(0xFF1976D2), // dein Blau (oder Theme.of(context).primaryColor)
            alignment: Alignment.center,
            child: const Text(
              'HanseFit wird geladen …',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}