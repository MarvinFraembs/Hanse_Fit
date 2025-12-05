// lib/ui/main_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'pages/studios_page.dart';
import 'pages/kurse_page.dart';
import 'pages/checkin_page.dart';
import 'pages/onlineplus_page.dart';
import 'pages/profil_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const KursePage(),
    const StudiosPage(),
    const CheckinPage(),
    const OnlineplusPage(),
    const ProfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  NavigationDestination _buildNavItem(
      IconData outlined, IconData filled, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return NavigationDestination(
      tooltip: '',
      icon: Icon(
        outlined,
        color: Colors.white.withOpacity(0.9),
        size: 24,
      ),
      selectedIcon: Icon(
        filled,
        color: const Color(0xFF1565C0),   // kräftiges Dunkelblau
        size: 24,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        key: const PageStorageKey<String>('page'),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF121212),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 20,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "STUDIOS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "KURSE",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: "CHECK-IN",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "ONLINE+",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "PROFIL",
          ),
        ],
      ),
    );
  }
}