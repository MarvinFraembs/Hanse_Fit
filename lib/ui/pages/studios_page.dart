import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudiosPage extends StatelessWidget {
  const StudiosPage({super.key});

  // Diese Funktion holt den Namen des Studios aus dem Speicher
  Future<String?> _getSavedStudio() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('studio'); 
  }

  Widget _buildStudioImages(String? studioName) {
    if (studioName == null || studioName.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Bitte wähle ein Studio im Menü aus.", 
            style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    if (studioName == 'FITNESSLAND Braunschweig Rebenpark') {
      return Column(
        children: [
          Image.asset('assets/images/rebenpark_1.png'),
          const SizedBox(height: 10),
          Image.asset('assets/images/rebenpark_2.png'),
        ],
      );
    } else if (studioName == 'FITNESSLAND Braunschweig Wilhelmstraße') {
      return Column(
        children: [
          Image.asset('assets/images/WS1.png'),
          Image.asset('assets/images/WS2.png'),
          Image.asset('assets/images/WS3.png'),
          Image.asset('assets/images/WS4.png'),
          Image.asset('assets/images/WS5.png'),
        ],
      );
    } else if (studioName == 'Hygia Braunschweig') {
      return Image.asset('assets/images/hygia_1.png');
    } 
    
    return const Center(
      child: Text("Keine Bilder für dieses Studio gefunden.", 
        style: TextStyle(color: Colors.white70)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. FutureBuilder als Basis nutzen
    return FutureBuilder<String?>(
      future: _getSavedStudio(),
      builder: (context, snapshot) {
        // 2. Variable aus dem Snapshot extrahieren
        final String? selectedStudio = snapshot.data;

        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.68,
                child: Image.asset(
                  'assets/images/Studios_Map2.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                ),
              ),

              // SearchBar Bereich
              Positioned(
                top: 60.5,
                left: 11.5,
                right: 65,
                child: Container(
                  height: 40,
                  child: SearchBar(
                    hintText: 'Partner finden',
                    leading: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(Icons.search, color: Color.fromARGB(255, 195, 194, 194)),
                    ),
                    elevation: const WidgetStatePropertyAll(2),
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(color: Color.fromARGB(255, 195, 194, 194), fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      const Color.fromARGB(255, 22, 22, 22).withOpacity(0.99),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                    ),
                    onChanged: (value) => print('Suche: $value'),
                  ),
                ),
              ),

              // Draggable Sheet
              DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.3,
                maxChildSize: 0.92,
                snap: true,
                snapSizes: const [0.3, 0.60, 0.92],
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 29, 29, 34),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 70,
                              height: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 207, 206, 206),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                            child: Text(
                              'Studioliste anzeigen',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 198, 197, 197),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                            child: Divider(
                              color: Color.fromARGB(255, 83, 82, 82),
                              thickness: 1.2,
                              height: 1,
                            ),
                          ),

                          // HIER werden jetzt die Bilder basierend auf dem Speicher geladen
                          _buildStudioImages(selectedStudio),

                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}