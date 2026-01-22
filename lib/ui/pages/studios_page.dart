import 'package:flutter/material.dart';

class StudiosPage extends StatelessWidget {
  const StudiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Studios'),
        backgroundColor: const Color(0xFF121212),
      ),
      body: const Center(
        child: Text('Studios', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}