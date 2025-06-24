import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'game_screen.dart';
import 'reward_screen.dart'; // Import der fehlenden RewardScreen

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(51, 96, 219, 1),
              Color.fromRGBO(25, 48, 109, 1),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 90.0),
                          child: Image.asset(
                            'assets/images/image_start.png',
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.5,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.25,
                        top: screenHeight * 0.15,
                        child: IconButton(
                          icon: const Icon(Icons.play_circle_fill, size: 80, color: Colors.green),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GameScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<GameProvider>(
                        builder: (context, gameProvider, child) {
                          int successCount = gameProvider.successCounter;
                          List<Widget> rewardImages = [];

                          for (int i = 0; i < successCount; i++) {
                            rewardImages.add(
                              Image.asset(
                                'assets/images/image_reward_apple.png',
                                width: screenWidth * 0.09,
                                height: screenWidth * 0.09,
                              ),
                            );
                          }

                          for (int i = successCount; i < 5; i++) {
                            rewardImages.add(
                              Image.asset(
                                'assets/images/image_reward_off.png',
                                width: screenWidth * 0.09,
                                height: screenWidth * 0.09,
                              ),
                            );
                          }

                          if (successCount >= 5) {
                            Future.delayed(Duration.zero, () {
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RewardScreen()),
                                );
                              }
                            });
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: rewardImages,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}