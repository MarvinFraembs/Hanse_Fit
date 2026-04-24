import 'package:flutter/material.dart';

class CheckedIn extends StatefulWidget {
  const CheckedIn({super.key});

  @override
  State<CheckedIn> createState() => _CheckedInState();
}

class _CheckedInState extends State<CheckedIn> {
  @override
  Widget build(BuildContext context) {
    // Deine definierten Farben
    const Color bgColor = Color.fromARGB(255, 29, 29, 34);
    const Color containerColor = Color.fromARGB(255, 50, 50, 50);
    const Color buttonColor = Color.fromARGB(255, 88, 137, 255);
    const Color successGreen = Colors.green; // Für den Check-in Streifen

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
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bitte zeige diesen Screen am Empfang, um Eintritt zu erhalten.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),

              // Haupt-Container
              Container(
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Oberer Bereich mit Image
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.network(
                          'https://via.placeholder.com/80', // Hier dein Logo/Bild einfügen
                          height: 40,
                        ),
                      ),
                    ),
                    
                    // Grüner Erfolgs-Streifen
                    Container(
                      width: double.infinity,
                      color: successGreen,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'CHECK-IN erfolgreich',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    // Profil Bereich (Zwei Spalten nebeneinander)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          // Linke Column mit Kreis-Bild
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.grey[700],
                                backgroundImage: const NetworkImage('https://via.placeholder.com/150'), // Profilbild
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          // Rechte Column mit Name und Icon
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Max Mustermann',
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Icon(Icons.verified_user, color: Colors.white54, size: 24),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Drei weitere Container
              _infoContainer(containerColor, "Braunschweig"),
              _infoContainer(containerColor, "Eingecheckt seit: 18:30 Uhr"),
              _infoContainer(containerColor, "Eingecheckt am: 24.04.2024"),

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
                  onPressed: () {},
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