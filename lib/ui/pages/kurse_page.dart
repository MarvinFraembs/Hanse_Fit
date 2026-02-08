import 'package:flutter/material.dart';

class KursePage extends StatefulWidget {
  const KursePage({super.key});

  @override
  State<KursePage> createState() => _KursePageState();
}

class _KursePageState extends State<KursePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollPosition);
  }

  void _checkScrollPosition() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      const threshold = 300.0;

      if (currentScroll >= maxScroll - threshold && !_isLoadingMore) {
        _loadMoreItems();
      }
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    // Simulierte Ladezeit (später echte API-Abfrage hier einfügen)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    List<String> weekdays = ['MO', 'DI', 'MI', 'DO', 'FR', 'SA', 'SO'];
    List<String> monthNames = [
      'JAN', 'FEB', 'MÄR', 'APR', 'MAI', 'JUN',
      'JUL', 'AUG', 'SEP', 'OKT', 'NOV', 'DEZ'
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
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
                      onPressed: () => print('Suche geklickt'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune_rounded, color: Colors.white),
                      onPressed: () => print('Einstellungen geklickt'),
                    ),
                  ],
                ),
              ),

              // Kalender
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
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${day.day}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              (day.day == 1 || isToday) ? monthNames[day.month - 1] : '',
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Horizontale Kategorien
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

              // Aktuelle Stunde
              _buildTimeHeader(_getCurrentHourRange()),

              const SizedBox(height: 12),
              _buildLiveCourseRow(
                time: _getCurrentHour1(),
                category: "Yoga",
                icon: Icons.self_improvement_rounded,
                title: "SOMATIC MEDITATION FOR STRESS RELIEVE (AUF ENGLISCH)",
                location: 'LiVeri - Yoga and More by Verena Aufderheide Dor...',
              ),

              const SizedBox(height: 16),

              _buildLiveCourseRow(
                time: _getCurrentHour2(),
                category: "Fitness",
                icon: Icons.fitness_center_rounded,
                title: "HIGH INTENSITY CORE TRAINING",
                location: 'HIT - Fitness Workouts by Matthias König Berlin',
              ),

              const SizedBox(height: 12),

              // Nächste Stunde
              _buildTimeHeader(_getNextHourRange()),

              const SizedBox(height: 12),

              _buildLiveCourseRow(
                time: _getCurrentHour3(),
                category: "Mentale Gesundheit",
                icon: Icons.psychology_rounded,
                title: "Achtsames Atmen",
                location: 'Mindful Moments by Anna Müller Hamburg',
              ),

              const SizedBox(height: 16),

              _buildLiveCourseRow(
                time: _getCurrentHour4(),
                category: "Fitness",
                icon: Icons.fitness_center_rounded,
                title: "LOW IMPACT FULL BODY WORKOUT",
                location: 'Low Impact Fitness by Lisa Schmidt München',
              ),

              const SizedBox(height: 10),

              // Ladebereich – wird bei Scroll nach unten getriggert
              if (_isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 44,
                          height: 44,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.8,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 89, 154, 228),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Weitere Kurse werden geladen …',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Center(
                    child: Text(
                      'Ende der aktuellen Liste',
                      style: TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                  ),
                ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeHeader(String timeRange) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 89, 154, 228),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          timeRange,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
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

  Widget _buildLiveCourseRow({
    required String time,
    required String category,
    required IconData icon,
    required String title,
    required String location,
  }) {
    return Padding(
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
                  color: const Color.fromARGB(255, 167, 228, 173),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    'LIVE',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(fontSize: 16, color: Colors.white)),
              const SizedBox(height: 4),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time_rounded, size: 12, color: Colors.white30),
                  SizedBox(width: 3),
                  Text(
                    '30 min',
                    style: TextStyle(fontSize: 10, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 12),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          color: const Color.fromARGB(255, 202, 202, 202),
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 202, 202, 202),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 12,
                        color: Colors.white30,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        location,
                        style: const TextStyle(
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
    );
  }

  String _getCurrentHourRange() {
    final now = DateTime.now();
    final start = now.hour.toString().padLeft(2, '0');
    final end = ((now.hour + 1) % 24).toString().padLeft(2, '0');
    return '$start:00 – $end:00';
  }

  String _getNextHourRange() {
    final now = DateTime.now();
    final start = (now.hour + 1).toString().padLeft(2, '0');
    final end = ((now.hour + 2) % 24).toString().padLeft(2, '0');
    return '$start:00 – $end:00';
  }

  String _getCurrentHour1() {
    final now = DateTime.now();
    return now.minute < 30 ? '${now.hour}:00' : '${now.hour}:25';
  }

  String _getCurrentHour2() {
    final now = DateTime.now();
    return now.minute < 30 ? '${now.hour}:05' : '${now.hour}:28';
  }

  String _getCurrentHour3() {
    final now = DateTime.now();
    return '${(now.hour + 1) % 24}:00';
  }

  String _getCurrentHour4() {
    final now = DateTime.now();
    return '${(now.hour + 1) % 24}:03';
  }
}