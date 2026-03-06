import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  CameraController? _cameraController;
  Future<void>? _initializeFuture;
  bool _cameraPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _checkCameraPermission();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      if (_tabController.index == 0) {
        if (_cameraPermissionGranted) _initializeCamera();
      } else {
        _disposeCamera();
      }
    });
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() => _cameraPermissionGranted = true);
      if (_tabController.index == 0) _initializeCamera();
    } else {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() => _cameraPermissionGranted = true);
        if (_tabController.index == 0) _initializeCamera();
      }
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _initializeFuture = _cameraController!.initialize();
      await _initializeFuture;
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Kamera Fehler: $e');
    }
  }

  void _disposeCamera() {
    _cameraController?.dispose();
    _cameraController = null;
    _initializeFuture = null;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Column(
        children: [
          // Tab-Bar (ohne AppBar)
          Container(
            color: const Color(0xFF121212),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Scannen'),
                Tab(text: 'CHECK-IN-ID'),
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[500],
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              padding: const EdgeInsets.symmetric(vertical: 4),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ── Tab 1: Scannen ────────────────────────────────────────
                _buildScanTab(),

                // ── Tab 2: CHECK-IN-ID ────────────────────────────────────
                _buildCheckInIdTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanTab() {
    if (!_cameraPermissionGranted) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.no_photography, size: 72, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('Kamera-Zugriff erforderlich', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => openAppSettings(),
              child: const Text('Einstellungen öffnen'),
            ),
          ],
        ),
      );
    }

    if (_cameraController == null || _initializeFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: FutureBuilder<void>(
        future: _initializeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }

          return Container(
            width: 320,           // ← kleine Kamera-Box
            height: 440,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Live Kamera-Preview
                CameraPreview(_cameraController!),

                // Overlay: kleines Kamera-Icon oben links
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),

                // Halbtransparentes graues QR-Code-Symbol in der Mitte
                Center(
                  child: Opacity(
                    opacity: 0.45,
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 140,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCheckInIdTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.numbers, size: 80, color: Colors.grey),
          const SizedBox(height: 24),
          const Text(
            'CHECK-IN-ID eingeben',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 40),
          TextField(
            decoration: InputDecoration(
              labelText: 'Code / ID',
              labelStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade900,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, letterSpacing: 1.2),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // Hier später Logik einfügen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Check-In', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}