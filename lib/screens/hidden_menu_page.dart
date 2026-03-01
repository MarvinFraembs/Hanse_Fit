import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiddenMenuPage extends StatefulWidget {
  const HiddenMenuPage({super.key});

  @override
  State<HiddenMenuPage> createState() => _HiddenMenuPageState();
}

class _HiddenMenuPageState extends State<HiddenMenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mitgliedsIdController = TextEditingController();
  final TextEditingController _aktivitaetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _mitgliedsIdController.text = prefs.getString('mitgliedsId') ?? '';
      _aktivitaetController.text = prefs.getString('aktivitaet') ?? '';
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('mitgliedsId', _mitgliedsIdController.text);
    await prefs.setString('aktivitaet', _aktivitaetController.text);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mitgliedsIdController.dispose();
    _aktivitaetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Menü')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mitgliedsIdController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Mitglieds-ID',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _aktivitaetController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Aktivität',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await _saveData();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gespeichert!')),
                );
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}