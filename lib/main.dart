// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'start_screen.dart';
import 'game_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Die Statusleiste ausblenden und in den immersiven Vollbildmodus wechseln
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Bildschirm auf Landscape (Querformat) fixieren
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Entfernt das Debug-Banner
      title: 'Endless Runner',
      home: StartScreen(),
    );
  }
}
