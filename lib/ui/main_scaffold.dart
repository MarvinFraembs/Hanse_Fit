// lib/ui/main_scaffold.dart
import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('STUDIOS', style: TextStyle(fontSize: 40))),
    Center(child: Text('KURSE', style: TextStyle(fontSize: 40))),
    Center(child: Text('CHECK-IN', style: TextStyle(fontSize: 40))),
    Center(child: Text('ONLINE+', style: TextStyle(fontSize: 40))),
    Center(child: Text('PROFIL', style: TextStyle(fontSize: 40))),
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, -4)),
          ],
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          height: 70,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          animationDuration: const Duration(milliseconds: 400),
          
          // WICHTIG: Labels immer anzeigen + immer weiß
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          
          // Schriftfarbe dauerhaft weiß (für aktive und inaktive Labels)
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(
              color: Colors.white,           // immer weiß
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
          ),
          
          destinations: [
            _buildNavItem(Icons.location_on, Icons.location_on, "STUDIOS", 0),
            _buildNavItem(Icons.calendar_today_outlined, Icons.calendar_today_outlined, "KURSE", 1),
            _buildNavItem(Icons.qr_code_scanner_rounded, Icons.qr_code_scanner_rounded, "CHECK-IN", 2),
            _buildNavItem(Icons.add_circle_outline, Icons.add_circle_outline, "ONLINE+", 3),
            _buildNavItem(Icons.account_circle_outlined, Icons.account_circle_outlined, "PROFIL", 4),
          ],
        ),
      ),
    );
  }
}