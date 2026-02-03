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

            const SizedBox(height:12),

            // Dunkelgrünes Widget
            Container(
              height: 190,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 27, 77, 68),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        '/home/marvin/Code/Hanse-Fit/hanse_fit_app/assets/images/Icon_Yazio.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 6), // Passt die Zahl an für mehr/weniger Abstand
                        child: Text(
                          'Yazio',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.info_outline,
                        size: 22,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Gesunde Gewohnheiten, die bleiben - mit Yazio Pro an deiner Seite.',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 246, 245, 245),
                    ),
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton(
                    onPressed: () {
                      // Aktion zum Gutscheincode
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Center(
                      child: Text(
                        'ZUM GUTSCHEINCODE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Dunkelblaues Widget
            Container(
              height: 220,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 28, 38, 52),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        '/home/marvin/Code/Hanse-Fit/hanse_fit_app/assets/images/Icon_7Schlaefer.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 6), // Passt die Zahl an für mehr/weniger Abstand
                        child: Text(
                          '7Schläfer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.info_outline,
                        size: 22,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Besser ein-, aus- und durchschlafen: Die 7Schläfer-App ermöglicht dir eine schnelle und wirksame Verbesserung deines Schlafs',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 246, 245, 245),
                    ),
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton(
                    onPressed: () {
                      // Aktion zum Gutscheincode
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Center(
                      child: Text(
                        'ZUM GUTSCHEINCODE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
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