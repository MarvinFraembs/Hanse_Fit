import 'package:flutter/material.dart';

class KursePage extends StatelessWidget {
  const KursePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Aktuelles Datum
    DateTime now = DateTime.now();

    // Liste der Wochentage (Deutsch)
    List<String> weekdays = ['MO', 'DI', 'MI', 'DO', 'FR', 'SA', 'SO'];
    List<String> monthNames = [
      'JAN',
      'FEB',
      'MÄR',
      'APR',
      'MAI',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OKT',
      'NOV',
      'DEZ'
    ];

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
                  const SizedBox(width: 6),
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
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 50, 50),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      DateTime day = now.add(Duration(days: index));
                      int weekdayIndex = day.weekday - 1;
                      bool isToday = index == 0;

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

            // Horizontale Pills
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCoursePill(Icons.fitness_center_outlined, 'Fitness'),
                    const SizedBox(width: 10),
                    _buildCoursePill(Icons.self_improvement_rounded, 'Pilates'),
                    const SizedBox(width: 10),
                    _buildCoursePill(Icons.psychology_rounded, 'Mentale Gesundheit'),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Blaue Zeitleiste
            Container(
              padding: const EdgeInsets.all(4),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 89, 154, 228),
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

            // Live + Kurs-Info Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      Container(
                        width: 45,
                        height: 24,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 167, 228, 173).withOpacity(1.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('LIVE', style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500)),
                          ],
                        ), // Unsichtbarer Text für die Höhe
                      ),
                      Text(_getCurrentHour1(), style: TextStyle(fontSize: 16, color: Colors.white)), 
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time_rounded,   // oder: Icons.timer_outlined, Icons.schedule
                            size: 12,
                            color: Colors.white30,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            '30 min',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),// Aktuelle Stunde als Text
                    ],
                  ),

                  const SizedBox(width: 12),

                  // Rechter grauer Bereich
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 62, 62, 62),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade800, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Kleines Rechteck mit Icon + Fitness
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.self_improvement_rounded,
                                  color: Color.fromARGB(255, 202, 202, 202),
                                  size: 14,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Yoga",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 202, 202, 202),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Kleiner Text darunter
                          const Text(
                            "SOMATIC MEDITATION FOR STRESS RELIEVE (AUF ENGLISCH)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.location_on_rounded,   // oder: Icons.timer_outlined, Icons.schedule
                                size: 12,
                                color: Colors.white30,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'LiVeri - Yoga and More by Verena Aufderheide Dor...',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 45,
                        height: 24,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 167, 228, 173).withOpacity(1.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text('LIVE', style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500)),
                          ],
                        ), // Unsichtbarer Text für die Höhe
                      ),
                      Text(_getCurrentHour2(), style: TextStyle(fontSize: 16, color: Colors.white)), 
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.access_time_rounded,   // oder: Icons.timer_outlined, Icons.schedule
                            size: 12,
                            color: Colors.white30,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            '30 min',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),// Aktuelle Stunde als Text
                    ],
                  ),

                  const SizedBox(width: 12),

                  // Rechter grauer Bereich
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 62, 62, 62),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade800, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Kleines Rechteck mit Icon + Fitness
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.fitness_center_rounded,
                                  color: Color.fromARGB(255, 202, 202, 202),
                                  size: 14,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Fitness",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 202, 202, 202),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Kleiner Text darunter
                          const Text(
                            "HIGH INTENSITY CORE TRAINING",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.location_on_rounded,   // oder: Icons.timer_outlined, Icons.schedule
                                size: 12,
                                color: Colors.white30,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'HIT - Fitness Workouts by Matthias König Berlin',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(4),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 89, 154, 228),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    _getNextHourRange(),
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
            // Restlicher Platz
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
                      'Hier können weitere Inhalte stehen\n(z. B. Liste der Kurse)',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
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

  Widget _buildCoursePill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 130, 125, 125), width: 1.5),
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
    return '$start:00 – $end:00';
  }

  String _getNextHourRange() {
    final now = DateTime.now();
    final startHour = now.hour+1;
    final endHour = (startHour + 1) % 24;
    final start = startHour.toString().padLeft(2, '0');
    final end = endHour.toString().padLeft(2, '0');
    return '$start:00 – $end:00';
  }
}

String _getCurrentHour1() {
  int hour = DateTime.now().hour;
  int min = DateTime.now().minute;

  if (min < 30) {
    return '$hour:00';
  } else {
    return '$hour:25';
  }

}

String _getCurrentHour2() {
  int hour = DateTime.now().hour;
  int min = DateTime.now().minute;

  if (min < 30) {
    return '$hour:00';
  } else {
    return '$hour:28';
  }
}