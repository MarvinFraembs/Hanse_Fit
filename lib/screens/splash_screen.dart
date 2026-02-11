import 'package:flutter/material.dart';
import 'dart:async';

// Ersetze den Import mit deinem tatsächlichen Pfad zur MainScaffold-Datei
import 'package:hanse_fit_app/ui/main_scaffold.dart';  // ← WICHTIG: anpassen!

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Warten bis der erste Frame gerendert ist → verhindert sehr viele Timing-Probleme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndNavigate();
    });
  }

  Future<void> _initializeAndNavigate() async {
    // ────────────────────────────────────────────────
    // Hier kommt später deine echte Initialisierungs-Logik hin
    // Beispiele:
    // await Future.wait([
    //   _initHive(),
    //   _loadSettings(),
    //   _checkAuth(),
    // ]);

    // Zum Testen / Debuggen: künstliche Wartezeit
    await Future.delayed(const Duration(milliseconds: 1800));

    // ────────────────────────────────────────────────

    if (!mounted) {
      debugPrint("SplashScreen wurde entsorgt bevor Navigation möglich war");
      return;
    }

    debugPrint("Splash → Navigation zu MainScaffold");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainScaffold(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // oder z. B. Theme.of(context).colorScheme.background
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2),

            // App-Name
            const Text(
              'HanseFit',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2), // Beispiel-Blau – gerne anpassen
                letterSpacing: 1.2,
              ),
            ),

            const Spacer(flex: 3),

            // Ladebalken + Text unten
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'wird geladen …',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}