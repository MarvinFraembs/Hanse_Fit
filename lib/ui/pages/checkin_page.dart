import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  bool showScan = true; // true = Scannen, false = CHECK-IN-ID

  CameraController? _cameraController;
  Future<void>? _initializeFuture;
  bool _cameraPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() => _cameraPermissionGranted = true);
      if (showScan) _initializeCamera();
    } else {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() => _cameraPermissionGranted = true);
        if (showScan) _initializeCamera();
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
    _disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // ── Tab-Buttons (wie CHECK-INS / BUCHUNGEN) ───────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showScan = true;
                          if (_cameraPermissionGranted) _initializeCamera();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: showScan
                                  ? const Color.fromARGB(255, 52, 135, 229)
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          'SCANNEN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: showScan
                                ? const Color.fromARGB(255, 52, 135, 229)
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showScan = false;
                          _disposeCamera();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: !showScan
                                  ? const Color.fromARGB(255, 52, 135, 229)
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          'CHECK-IN-ID',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !showScan
                                ? const Color.fromARGB(255, 52, 135, 229)
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Content ───────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: showScan ? _buildScanContent() : _buildIdContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 2),

            // Hinweistext oben – immer sichtbar
            const Text(
              'Scanne den QR-Code vor Ort im Studio.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                height: 1.3,
                letterSpacing: 0.6,
              ),
            ),

            const SizedBox(height: 20),

            // Kamera-Container mit rotem Eck-Rahmen – immer sichtbar
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 30, 30, 30),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(34.0),           // ← steuert die Rahmenstärke (hier 8 px Abstand = Rahmen)
                      decoration: ShapeDecoration(
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(57, 169, 168, 168),
                            width: 4,                               // oder hier die Stärke setzen
                          ),
                        ),
                        // color: Colors.transparent,               // nicht nötig – ShapeDecoration hat standardmäßig keinen Fill
                      ),
                      child: Image.asset(
                        'assets/images/Icon_QR_Code.png',
                        color: Color.fromARGB(57, 169, 168, 168),
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  
                  // Inhalt je nach Berechtigungsstatus
                  if (!_cameraPermissionGranted)
                    const Center(
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    )
                  else if (_cameraController == null || _initializeFuture == null)
                    const Center(child: CircularProgressIndicator())
                  else
                    FutureBuilder<void>(
                      future: _initializeFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Fehler: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CameraPreview(_cameraController!),
                        );
                      },
                    ),

                  Positioned(
                    top: 20,                    // Abstand von oben – passe nach Wunsch an (16–40)
                    left: 0,
                    right: 0,
                    child: const Center(
                      child: Icon(
                        Icons.flashlight_off_rounded,         // oder Icons.flashlight_on
                        size: 25,               // etwas kleiner, weil es oben liegt
                        color: Colors.white,  // dezent / halbtransparent
                        // shadows: [ ... ]     // optional: leichter Glow
                      ),
                    ),
                  ),

                  // Roter Rahmen in den Ecken – immer sichtbar
                  ...List.generate(4, (index) {
                    final alignments = [
                      Alignment.topLeft,
                      Alignment.topRight,
                      Alignment.bottomLeft,
                      Alignment.bottomRight,
                    ];
                    return Positioned.fill(
                      child: IgnorePointer(
                        child: Align(
                          alignment: alignments[index],
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border(
                                top: index < 2
                                    ? const BorderSide(color: Color.fromARGB(255, 241, 123, 123), width: 2)
                                    : BorderSide.none,
                                left: index == 0 || index == 2
                                    ? const BorderSide(color:Color.fromARGB(255, 241, 123, 123), width: 2)
                                    : BorderSide.none,
                                right: index == 1 || index == 3
                                    ? const BorderSide(color:Color.fromARGB(255, 241, 123, 123), width: 2)
                                    : BorderSide.none,
                                bottom: index >= 2
                                    ? const BorderSide(color: Color.fromARGB(255, 241, 123, 123), width: 2)
                                    : BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  // Optional: kleines Kamera-Icon (kann entfernt werden)
                  if (_cameraPermissionGranted)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // "CODE MANUELL EINGEBEN" – immer sichtbar
            const Text(
              'CODE MANUELL EINGEBEN',
              style: TextStyle(
                color: const Color.fromARGB(255, 52, 135, 229),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
              ),
            ),

            const SizedBox(height: 18),

            // Button "Manueller Check-in beim Partner" – immer sichtbar
            SizedBox(
              width: 300,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Hier Logik für Wechsel zum manuellen Modus / andere Seite
                  // z. B. setState(() => showScan = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wechsle zum manuellen Check-in...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(0, 254, 252, 252),
                  foregroundColor: const Color.fromARGB(255, 52, 135, 229),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color.fromARGB(255, 52, 135, 229), width: 2),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Manueller Check-in beim Partner',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 52, 135, 229)),
                ),
              ),
            ),

            const SizedBox(height: 11),

            // Info-Zeile mit Icon – immer sichtbar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Color.fromARGB(255, 52, 135, 229),
                  size: 26,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Wie funktioniert der Check-in?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 52, 135, 229),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildIdContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.numbers_rounded,
          size: 80,
          color: Color.fromARGB(255, 52, 135, 229),
        ),
        const SizedBox(height: 24),
        const Text(
          'CHECK-IN-ID eingeben',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 50, 50, 50),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Code / ID',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // Hier später deine Check-In-Logik
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Check-In wird verarbeitet...')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 52, 135, 229),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'Check-In durchführen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}