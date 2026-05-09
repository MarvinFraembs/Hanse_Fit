// lib/ui/main_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pages/studios_page.dart';
import 'pages/kurse_page.dart';
import 'pages/checkin_page.dart';
import 'pages/onlineplus_page.dart';
import 'pages/profil_page.dart';
import 'pages/checkedin.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  bool _isUserCheckedIn = false; // Status für Check-in

  // Funktion zum Umschalten des Status
  void _toggleCheckInStatus() {
    setState(() {
      _isUserCheckedIn = !_isUserCheckedIn;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // WICHTIG: Die Liste muss INNERHALB von build liegen, 
    // damit sie auf Änderungen von _isUserCheckedIn reagiert!
    final List<Widget> pages = [
      const StudiosPage(),
      const KursePage(),
      _isUserCheckedIn 
          ? CheckedIn(onCheckOut: _toggleCheckInStatus) 
          : CheckinPage(onCheckInSuccess: _toggleCheckInStatus),
      const OnlineplusPage(),
      const ProfilPage(),
    ];

    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        key: const PageStorageKey<String>('page'),
        child: IndexedStack(
          index: _selectedIndex,
          children: pages, // Nutzt die dynamische Liste
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 29, 29, 34),
        selectedItemColor: const Color.fromARGB(255, 88, 137, 255),
        unselectedItemColor: Colors.white,
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
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Kalendar_Icon.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "KURSE",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Qr-Code-Icon.svg',
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Qr-Code-Icon.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "CHECK-IN",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Plus_Icon.svg',
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Plus_Icon.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "ONLINE+",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Profil_Icon.svg',
              width: 24,
              height: 24,
            ),
            activeIcon: SvgPicture.asset(
              'assets/images/Profil_Icon.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 88, 137, 255), BlendMode.srcIn),
            ),
            label: "PROFIL",
          ),
        ],
      ),
    );
  }
}