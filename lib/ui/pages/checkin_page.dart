import 'package:flutter/material.dart';

class CheckinPage extends StatelessWidget {
  const CheckinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studios'),
        backgroundColor: const Color(0xFF121212),
      ),
      body: const Center(
        child: Text('STUDIOS', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}