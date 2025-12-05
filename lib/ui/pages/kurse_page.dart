import 'package:flutter/material.dart';

class KursePage extends StatelessWidget {
  const KursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KURSE'),
        backgroundColor: const Color(0xFF121212),
      ),
      body: const Center(
        child: Text('KURSE', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}