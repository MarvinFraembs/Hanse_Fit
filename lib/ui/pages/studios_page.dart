import 'package:flutter/material.dart';

class StudiosPage extends StatelessWidget {
  const StudiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studios'),
        backgroundColor: const Color(0xFF121212),
      ),
      body: Stack(
        children: [
          // Hintergrund-Bild – nimmt die gesamte Fläche ein
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
              fit: BoxFit.cover,
              // Alternativ: Asset-Bild verwenden
              // Image.asset('assets/images/gym_background.jpg', fit: BoxFit.cover),
            ),
          ),

          // Optional: dunkler Overlay, damit der Text besser lesbar wird
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          // Das hochziehbare Menü unten
          DraggableScrollableSheet(
            initialChildSize: 0.28, // Start-Höhe ≈ 28% → Bild ca. 72% sichtbar
            minChildSize: 0.28,     // Kann nicht kleiner werden
            maxChildSize: 0.92,     // Fast full-screen beim Hochziehen
            snap: true,             // Schöne Sprung-Animation zu den Größen
            snapSizes: const [0.28, 0.60, 0.92],
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
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
                          width: 42,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Titel
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text(
                          'Studioliste anzeigen',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Entfernungs-Filter (Beispiel)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text(
                          'Bis zu 1 km',
                          style: TextStyle(
                            fontSize: 16,
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
                              child: const Icon(
                                Icons.fitness_center,
                                color: Colors.deepPurple,
                                size: 28,
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