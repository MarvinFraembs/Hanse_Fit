import 'package:flutter/material.dart';

class StudiosPage extends StatelessWidget {
  const StudiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.68,
            child: Image.asset('assets/images/Studios_Map2.png',
              fit: BoxFit.fill,
              width: double.infinity,
              // fit: BoxFit.cover, // oder was du brauchst
              // color: Colors.white.withOpacity(0.4),     // je höher, desto heller
              // colorBlendMode: BlendMode.lighten,
            ),
          ),
          // Optional: dunkler Overlay, damit der Text besser lesbar wird
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          Positioned(
            top: 60.5,                    // Abstand von oben (anpassen!)
            left: 11.5,
            right: 65,
            child: Container(
              height: 40,
              
              child: SearchBar(           // ← Material 3 SearchBar (sehr empfehlenswert seit 2024/25)
                hintText: 'Partner finden',
                leading: Padding(padding:  const EdgeInsets.only(right: 4),
                child: Icon(Icons.search, color: Color.fromARGB(255, 195, 194, 194),),
                ),
                elevation: const MaterialStatePropertyAll(2),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Color.fromARGB(255, 195, 194, 194), fontWeight: FontWeight.w500),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  const Color.fromARGB(255, 22, 22, 22).withOpacity(0.99),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 7, vertical: 0), // horizontal = Innenabstand links/rechts
                ),
                onChanged: (value) {
                  // Hier deine Such-Logik
                  print('Suche: $value');
                },
                // Optional: onTap → öffnet volle Suche / Seite
              ),
            ),
          ),

          // Das hochziehbare Menü unten
          DraggableScrollableSheet(
            initialChildSize: 0.3, // Start-Höhe ≈ 28% → Bild ca. 72% sichtbar
            minChildSize: 0.3,     // Kann nicht kleiner werden
            maxChildSize: 0.92,     // Fast full-screen beim Hochziehen
            snap: true,             // Schöne Sprung-Animation zu den Größen
            snapSizes: const [0.3, 0.60, 0.92],
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 22, 22, 22),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 16,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag-Handle (optisch schön)
                      Center(
                        child: Container(
                          width: 70,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 207, 206, 206),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Titel
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: Text(
                          'Studioliste anzeigen',
                          style: TextStyle(
                            fontSize: 14,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 198, 197, 197),
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        child: Divider(
                          color: Color.fromARGB(255, 83, 82, 82),
                          thickness: 1.2,
                          height: 1,
                        ),
                      ),

                      // Entfernungs-Filter (Beispiel)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text(
                          'Bis zu 1 km',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Beispiel Studio-Eintrag
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            // Gym-Icon (kann durch ein echtes Icon ersetzt werden)
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset( 'assets/images/Icon_Gym.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Text(
                                'Vitality Braunschweig',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Weitere Studios können hier als Liste kommen
                      // z. B. ListView.builder oder weitere Rows

                      const SizedBox(height: 100), // Platz nach unten
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}