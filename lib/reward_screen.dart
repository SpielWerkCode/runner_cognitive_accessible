import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importiere den Provider
import 'game_provider.dart'; // Importiere den GameProvider
import 'start_screen.dart'; // Importiere den StartScreen

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Zeige das animierte GIF statt der 5 Bilder
            Image.asset(
              'assets/images/image_reward.gif', // Hier dein animiertes GIF
              width: 200, // Größe des GIFs, nach Belieben anpassen
              height: 200,
            ),
            const SizedBox(height: 20),
            // Home Icon Button anstelle des Textes
            IconButton(
              icon: const Icon(Icons.home, size: 60, color: Colors.blue), // Home Icon
              onPressed: () {
                // Beziehe den GameProvider und setze den Erfolgscounter zurück
                Provider.of<GameProvider>(context, listen: false).resetSuccessCounter();
                
                // Navigiere zum StartScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StartScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
