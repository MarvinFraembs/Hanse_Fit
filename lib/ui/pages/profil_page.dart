import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Header-Bereich
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'DEIN PROFIL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, color: Colors.white),
                    onPressed: () {
                      print('Einstellungen geklickt');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.mail_outline, color: Colors.white),
                    onPressed: () {
                      print('Nachrichten geklickt');
                    },
                  ),
                ],
              ),
            ),

            // Neues Profil-Info-Widget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 50, 50, 50), // etwas heller als Hintergrund
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rundes Profilbild
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage: null, // Hier später: NetworkImage('url') oder AssetImage
                          child: Icon(Icons.person, size: 40, color: Colors.white70),
                        ),
                        const SizedBox(width: 16),

                        // Rechte Seite: Name, Unternehmen, Status-Chips
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Max Mustermann', // <- Hier deinen Namen eintragen
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Mustermann Studios GmbH', // <- Dein Unternehmen
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Zwei Status-Chips nebeneinander
                              Row(
                                children: [
                                  Chip(
                                    backgroundColor: Colors.green.withOpacity(0.2),
                                    label: const Text(
                                      'aktiv',
                                      style: TextStyle(color: Colors.green, fontSize: 12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                  ),
                                  const SizedBox(width: 8),
                                  Chip(
                                    backgroundColor: Colors.amber.withOpacity(0.2),
                                    label: const Text(
                                      'best',
                                      style: TextStyle(color: Colors.amber, fontSize: 12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Blaue untere Leiste mit Mitglied-ID
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.blue,
                      // decoration: const BoxDecoration(
                      //   color: Colors.blue,
                      //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                      // ),
                      child: const Text(
                        'Mitglied-ID: 123456', // <- Deine echte ID hier eintragen
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Platzhalter für weiteren Inhalt (z. B. STUDIOS oder andere Sections)
            const Expanded(
              child: Center(
                child: Text(
                  'STUDIOS',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}