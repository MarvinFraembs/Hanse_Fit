// lib/ui/main_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    const StudiosPage(),
    const KursePage(),
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
        color: Colors.white,
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
        backgroundColor:  Color.fromARGB(255, 29, 29, 34),
        selectedItemColor: Color.fromARGB(255, 88, 137, 255),
        unselectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(opacity: 1.0),
        unselectedIconTheme: const IconThemeData(opacity: 1.0),
        selectedFontSize: 10,
        unselectedFontSize: 10,
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
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "STUDIOS",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Kalendar_Icon.svg',
              width: 24,
              height: 24,
              //colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Kalendar_Icon.svg',
              width: 24,
              height: 24,
              // Die Farbe für den ausgewählten Zustand
              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "KURSE",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Qr-Code-Icon.svg',
              width: 24,
              height: 24,
              //colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Qr-Code-Icon.svg',
              width: 24,
              height: 24,
              // Die Farbe für den ausgewählten Zustand
              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "CHECK-IN",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Plus_Icon.svg',
              width: 24,
              height: 24,
              //colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Plus_Icon.svg',
              width: 24,
              height: 24,
              // Die Farbe für den ausgewählten Zustand
              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "ONLINE+",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Profil_Icon.svg',
              width: 24,
              height: 24,
              //colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Profil_Icon.svg',
              width: 24,
              height: 24,
              // Die Farbe für den ausgewählten Zustand
              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "PROFIL",
          ),
        ],
      ),
    );
  }
}