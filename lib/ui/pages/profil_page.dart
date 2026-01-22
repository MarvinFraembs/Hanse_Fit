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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 50, 50, 50),
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
                    // Padding nur für den oberen Content-Bereich
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Rundes Profilbild
                          const CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey,
                            backgroundImage: null,
                            child: Icon(Icons.person, size: 40, color: Colors.white70),
                          ),
                          const SizedBox(width: 16),
                          // Rechte Seite: Name, Unternehmen, Status-Chips
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Max Mustermann',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                const Text(
                                  'Mustermann Studios GmbH',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Zwei Status-Chips nebeneinander
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 167, 245, 170).withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                      child: const Text(
                                        'AKTIV',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 50, 50, 50),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                      child: const Text(
                                        'Best',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Blaue untere Leiste mit Mitglied-ID (geht bis zum Rand)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Mitglieds-ID:',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '123456',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tab-Bereich für CHECK-INS und BUCHUNGEN
            const SizedBox(height: 16),
            const CheckInsBuchungenSection(),
          ],
        ),
      ),
    );
  }
}

// Neues Widget für CHECK-INS und BUCHUNGEN
class CheckInsBuchungenSection extends StatefulWidget {
  const CheckInsBuchungenSection({super.key});

  @override
  State<CheckInsBuchungenSection> createState() => _CheckInsBuchungenSectionState();
}

class _CheckInsBuchungenSectionState extends State<CheckInsBuchungenSection> {
  bool showCheckIns = true; // true = CHECK-INS, false = BUCHUNGEN

  @override
  Widget build(BuildContext context) {
    // Aktuelles Datum
    DateTime now = DateTime.now();
    
    // Finde den Montag der aktuellen Woche
    int daysFromMonday = now.weekday - 1;
    DateTime monday = now.subtract(Duration(days: daysFromMonday));
    
    // Liste der Wochentage (Deutsch)
    List<String> weekdays = ['MO.', 'DI.', 'MI.', 'DO.', 'FR.', 'SA.', 'SO.'];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Tab-Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showCheckIns = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: showCheckIns ? Color.fromARGB(255, 52, 135, 229) : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'CHECK-INS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: showCheckIns ? Color.fromARGB(255, 52, 135, 229) : Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showCheckIns = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: !showCheckIns ? Color.fromARGB(255, 52, 135, 229) : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'BUCHUNGEN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !showCheckIns ? Color.fromARGB(255, 52, 135, 229) : Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Content-Bereich
            if (showCheckIns)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 50, 50, 50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CHECK-INS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'SansSerif',
                                ),
                              ),
                              Text(
                                'der letzten 30 Tage',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),


                          // child: Text(
                          //   'CHECK-INS\nder letzten 30 Tage',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100), // ← Halbe Breite/Höhe für perfekten Kreis
                            border: Border.all(
                              color:Color.fromARGB(255, 52, 135, 229), // Farbe der Umrandung
                              width: 1.0, // Dicke der Linie
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color:Color.fromARGB(255, 52, 135, 229),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 50, 50, 50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'CHECK-INS IN DIESER WOCHE: 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // HIER IST DER WOCHENTAGE-CONTAINER
                  Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        DateTime day = monday.add(Duration(days: index));
                        bool isToday = day.day == now.day && 
                                       day.month == now.month && 
                                       day.year == now.year; 
                        bool isTodayOrPast = day.isBefore(now) || 
                                      (day.day == now.day && 
                                      day.month == now.month && 
                                      day.year == now.year);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              weekdays[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isToday ? Color.fromARGB(255, 52, 135, 229) : Colors.transparent,
                                border: Border.all(
                                  color: isToday ? Color.fromARGB(255, 52, 135, 229) : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${day.day}',
                                  style: TextStyle(
                                    color: isTodayOrPast ? Colors.white : Colors.white30,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Color.fromARGB(255, 52, 135, 229),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'ALLE CHECK-INS ANSEHEN',
                        style: TextStyle(
                          color: Color.fromARGB(255, 52, 135, 229),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              )
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 50, 50, 50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Keine Buchungen',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
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