import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game_state.dart';

import 'dart:async';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'mygame.dart'; // Importiere die MyGame Klasse

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});



  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late GameState gameState;
  late MyGame game; // Definiere eine Variable vom Typ MyGame
  bool showCollisionImage = false;
  bool showAppleImage = false;
  late Timer gameTimer;

  @override
  void initState() {
    super.initState();
    gameState = GameState();
    gameState.initializeGame(this, _updateGame);

    // Initialisiere die MyGame Instanz
    game = MyGame();

    // Startet einen Timer, der nach nn Sekunden das Spiel als erfolgreich beendet betrachtet
    gameTimer = Timer(const Duration(seconds: 30), () {
      _onGameSuccess();
    });
  }

  void _updateGame() {
    setState(() {
      double currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
      double dt = (currentTime - gameState.lastUpdateTime) / 1000;
      gameState.lastUpdateTime = currentTime;
      gameState.updateGame(dt, _onGameOver);
    });
  }

  void _onGameOver() {
    setState(() {
      game.pauseEngine();
      gameState.playerY = 2;
      showCollisionImage = true;
      Future.delayed(const Duration(milliseconds: 800), () {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
    });
  }

  void _onGameSuccess() {
    setState(() {
      game.pauseEngine();
      showAppleImage = true;
      Provider.of<GameProvider>(context, listen: false).incrementSuccessCounter();
      Future.delayed(const Duration(seconds: 3), () {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
    });
  }

  @override
  void dispose() {
    gameState.dispose();
    gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Verwende die MyGame Instanz, um das Spiel anzuzeigen
          GameWidget(game: game),
          GestureDetector(
            onTap: () {
              if (gameState.gameOver) {
                Navigator.pop(context);
              } else {
                setState(() {
                  gameState.jump();
                });
              }
            },
            child: Stack(
              children: [
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(-0.5, gameState.playerY),
                    child: SizedBox(
                      width: gameState.getSize("cat", context),
                      height: gameState.getSize("cat", context),
                      child: Image.asset(
                        gameState.playerY < 0
                            ? 'assets/images/image_cat_jump.png'
                            : 'assets/images/image_cat.gif',
                      ),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_1, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_1),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_2, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_2),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_3, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_3),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_4, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_4),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_5, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_5),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_6, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_6),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_7, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_7),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_8, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_8),
                    ),
                  ),
                if (!showAppleImage)
                  Align(
                    alignment: Alignment(gameState.obstacleX_9, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("dog", context),
                      height: gameState.getSize("dog", context),
                      child: Image.asset(gameState.typeObstacle_9),
                    ),
                  ),
                if (showCollisionImage && !showAppleImage)
                  Align(
                    alignment: const Alignment(-0.43, 0.35),
                    child: SizedBox(
                      width: gameState.getSize("collision", context),
                      height: gameState.getSize("collision", context),
                      child: Image.asset('assets/images/image_collision.png'),
                    ),
                  ),
                if (showAppleImage)
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/images/image_reward_apple.png'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
