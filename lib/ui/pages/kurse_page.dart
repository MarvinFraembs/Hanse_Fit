import 'package:flutter/material.dart';

class KursePage extends StatelessWidget {
  const KursePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Aktuelles Datum
    //DateTime now = DateTime.now();
    DateTime now = DateTime(2026,1,30);

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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
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
                    icon: const Icon(Icons.today_outlined, color: Colors.white),
                    onPressed: () {
                      print('Heute geklickt');
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
                                  ? const Color.fromARGB(255, 52, 135, 229)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isToday
                                    ? const Color.fromARGB(255, 52, 135, 229)
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
                            isToday ? monthNames[day.month - 1] : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),

                          Text(
                            (day.day == 1 && !isToday) ? monthNames[day.month - 1] : '',
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