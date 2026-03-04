import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class HiddenMenuPage extends StatefulWidget {
  const HiddenMenuPage({super.key});

  @override
  State<HiddenMenuPage> createState() => _HiddenMenuPageState();
}

class _HiddenMenuPageState extends State<HiddenMenuPage> {
  final _nameController = TextEditingController();
  final _mitgliedsIdController = TextEditingController();
  final _unternehmenController = TextEditingController();

  String? _profileImagePath;        // ← hier wird der Pfad gespeichert
  final ImagePicker _picker = ImagePicker();

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
      _unternehmenController.text = prefs.getString('arbeitgeber') ?? '';
      _profileImagePath = prefs.getString('profileImagePath');
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('mitgliedsId', _mitgliedsIdController.text);
    await prefs.setString('arbeitgeber', _unternehmenController.text);
    if (_profileImagePath != null) {
      await prefs.setString('profileImagePath', _profileImagePath!);
    }
  }

  Future<void> _pickAndSaveImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,   // oder: ImageSource.camera
        // maxWidth: 800,   // ← optional: verkleinern
        // maxHeight: 800,
        // imageQuality: 85,
      );

      if (pickedFile == null) return;

      // Zielverzeichnis: app documents directory
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String newPath = path.join(appDocDir.path, fileName);

      // Bild in unseren App-Ordner kopieren
      final File newFile = await File(pickedFile.path).copy(newPath);

      setState(() {
        _profileImagePath = newFile.path;
      });

      // Sofort speichern (oder erst beim Button)
      await _saveData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profilbild gespeichert!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Laden des Bildes: $e')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mitgliedsIdController.dispose();
    _unternehmenController.dispose();
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
            // ── Profilbild Vorschau + Button ────────────────────────
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white70, width: 2),
                    ),
                    child: _profileImagePath != null && File(_profileImagePath!).existsSync()
                        ? ClipOval(
                            child: Image.file(
                              File(_profileImagePath!),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person, size: 60, color: Colors.white54),
                            ),
                          )
                        : const Icon(Icons.person, size: 60, color: Colors.white54),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _pickAndSaveImage,
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Profilbild ändern'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

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
              controller: _unternehmenController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Arbeitgeber',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () async {
                await _saveData();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Alle Daten gespeichert!')),
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