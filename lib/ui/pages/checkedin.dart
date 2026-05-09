import 'package:flutter/material.dart';
import 'checkin_page.dart';

class CheckedIn extends StatefulWidget {
  final VoidCallback onCheckOut;
  const CheckedIn({super.key, required this.onCheckOut});

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
                  color: containerColor, // Die Farbe für den unteren Teil
                  borderRadius: BorderRadius.circular(8),
                ),
                // clipBehavior sorgt dafür, dass die Kinder nicht über die abgerundeten Ecken ragen
                clipBehavior: Clip.antiAlias, 
                child: Column(
                  children: [
                    // --- NEUER DUNKLER BEREICH ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 0), // Padding für oben/unten
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 35, 35, 35), // Dein dunklerer Grauton
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
                      color: Color(0xFFA8E6CF),
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
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.2, 0.2),
                                color: Color.fromARGB(255, 50, 50, 50),
                              ),
                              Shadow(
                                offset: Offset(-0.2, -0.2),
                                color: Color.fromARGB(255, 50, 50, 50),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Profil Bereich (Dieser Teil bleibt in 'containerColor')
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey[700],
                            backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
                          ),
                          const SizedBox(width: 20),
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