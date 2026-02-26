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
    await Future.delayed(const Duration(milliseconds: 600));

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
          Container(
            height: MediaQuery.of(context).size.height * 0.985,
            child: Image.asset(
              'assets/images/Hanse_Fit_Loading_Page.jpg',
              //fit: BoxFit.cover,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Expanded(  // ← füllt den restlichen Platz automatisch
            child: Container(
              color: const Color.fromARGB(255, 5, 26, 82),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}