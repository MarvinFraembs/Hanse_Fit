import 'dart:io'; // --- WICHTIG: Für den Zugriff auf lokale Dateien (Profilbild) ---
import 'dart:async'; // --- WICHTIG: Für den Timer benötigt ---
import 'package:flutter/material.dart';
import 'checkin_page.dart';
import 'package:hanse_fit_app/services/app_preferences.dart';

class CheckedIn extends StatefulWidget {
  final VoidCallback onCheckOut;
  const CheckedIn({super.key, required this.onCheckOut});

  @override
  State<CheckedIn> createState() => _CheckedInState();
}

class _CheckedInState extends State<CheckedIn> {
  String _username = '';
  String _mitgliedsId = '';
  String _arbeitgeber = '';
  String? _profileImagePath;
  String _studio = '';

  Timer? _timer;
  DateTime? _checkInDateTime; // Speichert den exakten Startzeitpunkt

  String _elapsedTimeStr = "00:00:00"; // Startwert für den Timer
  String _checkInDate = "01.01.2026";

  @override
  void initState() {
    super.initState();
    _loadData();
    _setCurrentTimeAndDate();
  }

  Future<void> _loadData() async {
    final name = await AppPreferences.getName();
    final mitgliedsId = await AppPreferences.getMitgliedsId();
    final arbeitgeber = await AppPreferences.getArbeitgeber();
    final imagePath = await AppPreferences.getProfileImagePath();
    final studio = await AppPreferences.getStudio();

    if (!mounted) return;

    setState(() {
      _username = name;
      _studio = studio;
      _mitgliedsId = mitgliedsId;
      _arbeitgeber = arbeitgeber;
      _profileImagePath = imagePath;
    });
  }

  void _setCurrentTimeAndDate() {
    // Zeitpunkt des Check-ins JETZT festlegen
    _checkInDateTime = DateTime.now();
    
    // Tag, Monat und Jahr für den Datums-Container formatieren
    final String day = _checkInDateTime!.day.toString().padLeft(2, '0');
    final String month = _checkInDateTime!.month.toString().padLeft(2, '0');
    final String year = _checkInDateTime!.year.toString();

    // Timer starten
    _startTimer();

    setState(() {
      _checkInDate = "$day.$month.$year";
    });
  }

  void _startTimer() {
    // Der periodische Timer läuft jede Sekunde
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_checkInDateTime == null) return;

      final now = DateTime.now();
      final difference = now.difference(_checkInDateTime!);

      // Berechne die vergangenen Stunden, Minuten und Sekunden seit dem Öffnen des Screens
      final hours = difference.inHours.toString().padLeft(2, '0');
      final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

      if (mounted) {
        setState(() {
          // Setzt den String im gewünschten Format mit Leerzeichen neu
          _elapsedTimeStr = "$hours:$minutes:$seconds"; 
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Schließt den Timer, wenn der Screen verlassen wird (wichtig gegen Memory Leaks!)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Deine definierten Farben
    const Color bgColor = Color.fromARGB(255, 29, 29, 34);
    const Color containerColor = Color.fromARGB(255, 50, 50, 50);
    const Color buttonColor = Color.fromARGB(255, 88, 137, 255);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Bereich
              const Text(
                'CHECK-IN',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.0),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bitte zeige diesen Screen am Empfang, um Eintritt zu erhalten.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1.2),
              ),
              const SizedBox(height: 30),

              // Haupt-Container
              Container(
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias, 
                child: Column(
                  children: [
                    // --- NEUER DUNKLER BEREICH ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 35, 35, 35),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/Checkin_HanseFit.png',
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                    
                    // Grüner Erfolgs-Streifen
                    Container(
                      width: double.infinity,
                      color: const Color(0xFFA8E6CF),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CHECK-IN ERFOLGREICH',
                            style: TextStyle(color:Color.fromARGB(255, 50, 50, 50), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.check_rounded,
                            color: Color.fromARGB(255,50,50,50), 
                            size: 16,
                          ),
                        ],
                      ),
                    ),

                    // Profil Bereich
                    Padding(
                      padding:  EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey[700],
                            backgroundImage: _profileImagePath != null
                              ? FileImage(File(_profileImagePath!)) // Das '!' sagt Flutter: "Ich garantiere, es ist nicht null"
                              : const AssetImage('assets/images/placeholder_profile.png'),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _username,
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(999),
                                ),
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      //padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                              color: Colors.transparent,
                                            ),
                                            child: Image.asset(
                                              'assets/images/Icon_Hanse_Fit.png',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 1),
                                          Text(
                                            'Best',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                        ],
                                      ) 
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 0, bottom: 2),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                // Wir nehmen das Center-Widget komplett weg und zentrieren direkt das Text-Element
                child: Text(
                  _studio,
                  textAlign: TextAlign.center, // <--- Zwingt den Text genau in die Mitte
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 15, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // --- CONTAINER MIT DEM FILTRIERTEN LIVE-TIMER ---
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top:0, bottom: 2),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Eingecheckt seit", style: TextStyle(color: Colors.white60, fontSize: 13)),
                    // Hier wird jetzt die Timer-Variable genutzt:
                    Text(_elapsedTimeStr, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // --- CONTAINER FÜR DAS DATUM ---
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Eingecheckt am", style: TextStyle(color: Colors.white60, fontSize: 13)),
                    Text(_checkInDate, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Footer Text
              const Text(
                'Bitte denk daran dich auszuchecken, wenn du das Studio verlässt.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60, fontSize: 13),
              ),
              const SizedBox(height: 15),

              // Check-Out Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onCheckOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'CHECK-OUT',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hilfsmethode für die kleineren Info-Container
  Widget _infoContainer(Color color, String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}