import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hanse_fit_app/ui/main_scaffold.dart'; // Pfad anpassen!
import 'hidden_menu_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigateToHiddenMenu = false; // ← neu

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndNavigate();
    });
  }

  Future<void> _initializeAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    if (_navigateToHiddenMenu) return; // ← neu: abbrechen wenn Button gedrückt
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainScaffold(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.985,
                child: Image.asset(
                  'assets/images/Hanse_Fit_Loading_Page.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 5, 26, 82),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _navigateToHiddenMenu = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HiddenMenuPage()),
                ).then((_) {
                  if (!mounted) return;
                  // Direkt zum MainScaffold wenn HiddenMenu geschlossen wird
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainScaffold(),
                    ),
                  );
                });
              },
              child: Container(
                width: 120,
                height: 120,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}