import 'package:flutter/material.dart';

class KursePage extends StatelessWidget {
  const KursePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Aktuelles Datum
    DateTime now = DateTime.now();

    // Liste der Wochentage (Deutsch)
    List<String> weekdays = ['MO', 'DI', 'MI', 'DO', 'FR', 'SA', 'SO'];

    List<String> monthNames = ['JAN', 'FEB', 'MÄR', 'APR', 'MAI', 'JUN', 
                               'JUL', 'AUG', 'SEP', 'OKT', 'NOV', 'DEZ'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const SizedBox(width:6),
                  const Text(
                    'ONLINE KURSE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      print('Suche geklickt');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune_rounded, color: Colors.white),
                    onPressed: () {
                      print('Einstellungen geklickt');
                    },
                  ),
                ],
              ),
            ),
            
            // Kalender-Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 50, 50, 50),
              ),
              child: Column(
                children: [
                  // Wochentage-Row
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      DateTime day = now.add(Duration(days: index));
                      int weekdayIndex = day.weekday - 1;
                      bool isToday = index == 0;
                      //bool isFirstOfMonth = DateTime.now().day == 0;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            weekdays[weekdayIndex],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isToday
                                  ? const Color.fromARGB(255, 89, 154, 228)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isToday
                                    ? const Color.fromARGB(255, 89, 154, 228)
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),

                          Text(
                            (day.day == 1 || isToday) ? monthNames[day.month - 1] : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 32, // Höhe der Pills – passe bei Bedarf an (44–60 ist meist gut)
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCoursePill(Icons.fitness_center_outlined, 'Fitness'),
                    const SizedBox(width: 10),
                    _buildCoursePill(Icons.self_improvement_rounded, 'Pilates'),
                    const SizedBox(width: 10),
                    _buildCoursePill(Icons.psychology_rounded, 'Mentale Gesundheit Kurs'),
                    const SizedBox(width: 10), // optional: Platz am Ende
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 154, 228),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    _getCurrentHourRange(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],    
              ),
            ),

            const SizedBox(height: 12),
                        // Weitere Inhalte können hier hinzugefügt werden
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 50, 50, 50),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'Hier können weitere Inhalte stehen',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }

Widget _buildCoursePill(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 130, 125, 125), width: 1.5),
      borderRadius: BorderRadius.circular(30), // stark abgerundet → Pill-Look
      color: Colors.transparent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min, // wichtig: nur so breit wie Inhalt
      children: [
        Icon(
          icon,
          color: const Color.fromARGB(255, 144, 139, 139),
          size: 16,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

String _getCurrentHourRange() {
  final now = DateTime.now();
  final startHour = now.hour;
  final endHour = (startHour + 1) % 24;

  final start = startHour.toString().padLeft(2, '0');
  final end = endHour.toString().padLeft(2, '0');

  return '$start:00 - $end:00';
}
