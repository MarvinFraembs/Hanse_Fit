import 'package:flutter/material.dart';

class OnlineplusPage extends StatelessWidget {
  const OnlineplusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 29, 29), 
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hellgraues Widget - nimmt 1/4 der Bildschirmhöhe ein
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 40, 39, 39), // Hellgrau
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ONLINE +',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'GLÜCKWUNSCH: MIT DEINER MITGLIEDSCHAFT HAST DU ZUGRIFF AUF AUSGEWÄHLTE ONLINE+ ANGEBOTE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0), // Nur links und rechts
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ENTDECKE DEINEN ONLINE+ BEREICH',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8), // Abstand zwischen den Texten
                  Text(
                    'Hansefit bietet exklusive Online-Angebote aus den Bereichen Fitness, Meditation, Ernährung, Outdoor und Yoga. Auf welche davon du Zugriff hast, hängt von deiner Mitgliedschaft ab und kannst du hier bequem einsehen. Für alle aufgeführten Angebote erhältst du einen 100%-Gutscheincode und kannst diese somit gratis nutzen.',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 225, 224, 224),
                    ),
                  ),
                ],
              ),
            ),

            // Dunkelgrünes Widget
            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1B4332), // Sehr dunkles Grün
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Grüner Bereich',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Dunkelblaues Widget
            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B2A), // Dunkles Blau
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Blauer Bereich',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Etwas Abstand am Ende
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}