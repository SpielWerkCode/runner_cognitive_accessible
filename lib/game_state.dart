import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameState {
  double playerY = 0.35;
  double obstacleX = 1.4;
  double speed = 0.5;
  bool gameOver = false;
  late AnimationController controller;

  double lastUpdateTime = 0;
  late double pxPerSec; // Pixel pro Sekunde, muss selber Wert sein wie Background
  late double startTime;

  late double screenWidth;
  late double screenHeight;
  late double devicePixelRatio;

  double bgW = 1600;
  double bgH = 400;
  double bgTime = 9.2; // Zeit für Durchlauf von Hintergrundbild, muss identisch sein mit background_component
  int jumpDurationMs = 1500;
  double scaleDog = 0.4;
  double scaleCat = 0.3;  
  double scaleCollision = 0.4;
  double scaleDefault = 0.5;
  late double genScale;
  double xMIN = -0.68; // Absprung Kollisions-Fenster
  double xMAX = -0.26; // Landung Kollisions-Fenster

  late double xStartObstacle_1; // Start x-Position von Hindernis 1
  late String typeObstacle_1;
  double obstacleX_1 = 0; // akutelle x-Position von Hindernis 1
  late double xStartObstacle_2; // Start x-Position von Hindernis 2
  late String typeObstacle_2;
  double obstacleX_2 = 0; // akutelle x-Position von Hindernis 2
  late double xStartObstacle_3; // Start x-Position von Hindernis 3
  late String typeObstacle_3;
  double obstacleX_3 = 0; // akutelle x-Position von Hindernis 3
  late double xStartObstacle_4; // Start x-Position von Hindernis 4
  late String typeObstacle_4;
  double obstacleX_4 = 0; // akutelle x-Position von Hindernis 4
  late double xStartObstacle_5; // Start x-Position von Hindernis 5
  late String typeObstacle_5;
  double obstacleX_5 = 0; // akutelle x-Position von Hindernis 5
  late double xStartObstacle_6; // Start x-Position von Hindernis 6
  late String typeObstacle_6;
  double obstacleX_6 = 0; // akutelle x-Position von Hindernis 6
  late double xStartObstacle_7; // Start x-Position von Hindernis 7
  late String typeObstacle_7;
  double obstacleX_7 = 0; // akutelle x-Position von Hindernis 7
  late double xStartObstacle_8; // Start x-Position von Hindernis 8
  late String typeObstacle_8;
  double obstacleX_8 = 0; // akutelle x-Position von Hindernis 8
  late double xStartObstacle_9; // Start x-Position von Hindernis 9
  late String typeObstacle_9;
  double obstacleX_9 = 0; // akutelle x-Position von Hindernis 9

  final List<String> obstacles = [
    'assets/images/image_dog.png',
    'assets/images/image_doghouse.png',
    'assets/images/image_hen.png',
    'assets/images/image_pond.png',
    'assets/images/image_fence.png',
    'assets/images/image_basket.png'
  ];

  void initializeGame(TickerProvider vsync, VoidCallback updateCallback) {
    playerY = 0.35;
    gameOver = false;

    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 16),
    )..addListener(updateCallback);

    lastUpdateTime = DateTime.now().millisecondsSinceEpoch.toDouble();
    controller.repeat();

    // NEUE BERECHNUNG INITIALISIERUNG

    // Speichere die Startzeit, wenn das Hintergrundelement geladen wird
    startTime = DateTime.now().millisecondsSinceEpoch.toDouble();

    // Breite und Höhe in logischen Pixeln erhalten:
    screenWidth = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width;
    screenHeight = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height;
    devicePixelRatio = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    screenWidth = screenWidth / devicePixelRatio;
    screenHeight = screenHeight / devicePixelRatio;
    //print('screenWidth: $screenWidth px');
    genScale = screenWidth/2*0.95;
    pxPerSec = bgW / bgH * screenHeight  / bgTime;
    pxPerSec = pxPerSec * screenWidth / ( screenWidth - genScale*scaleDog );
    // sollte fuer A40 etwa 160 bis 200 sein (haengt von scaleDog ab)
    double secOneScreen =  screenWidth / pxPerSec;
    // Sprungweite
    double jumpRelScreen = 0.45; // Einstellung Sprungweite relativer Faktor zur Bildschirmbreite | 0.52 ist etwa 2 Sekunden
    jumpDurationMs = (secOneScreen * jumpRelScreen * 1000).toInt();

    // Hindernisse Startwerte
    double xBase = screenWidth + 300; // Start erstes Hinternis (rechts ausserhalb Bildschirm)
    Random random = Random();
    double xDiffMin = 500; // minimaler Abstand zwischen Hinternissen (wird später mit screenWidth skaliert)
    double xDiffRange = 1.2; // effektiver Abstand um Zufallszahl gestreckt

    typeObstacle_1 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_2 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_3 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_4 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_5 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_6 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_7 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_8 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ
    typeObstacle_9 = obstacles[Random().nextInt(obstacles.length)]; // zufälliger Hindernis-Typ

    xStartObstacle_1 = xBase; // Hindernis 1 Start-Position
    xStartObstacle_2 = ((xStartObstacle_1+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position
    xStartObstacle_3 = ((xStartObstacle_2+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position
    xStartObstacle_4 = ((xStartObstacle_3+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position
    xStartObstacle_5 = ((xStartObstacle_4+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position
    xStartObstacle_6 = ((xStartObstacle_5+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position
    xStartObstacle_7 = ((xStartObstacle_6+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position
    xStartObstacle_8 = ((xStartObstacle_7+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position
    xStartObstacle_9 = ((xStartObstacle_8+xDiffMin)/screenWidth+random.nextDouble()*xDiffRange)*screenWidth; // Hindernis 2 Start-Position


    // NEUE BERECHNUNG 
  }

  double getSize(String key, BuildContext context) {
    //screenHeight = MediaQuery.of(context).size.height;
    //screenWidth = MediaQuery.of(context).size.width;
    switch (key) {
      case 'dog':
        return genScale * scaleDog;
      case 'cat':
        return genScale * scaleCat;
      case 'collision':
        return genScale * scaleCollision;
      default:
        return genScale * scaleDefault;
    }
  }

  void updateGame(double dt, VoidCallback onGameOver) {
    if (!gameOver) {

      // Berechne die verstrichene Zeit (in Sekunden)
      double currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
      double diffTime = (currentTime - startTime) / 1000;  // diffTime in Sekunden
      //print('OB Verstrichene Zeit: $diffTime Sekunden');
      double xDiff = diffTime * pxPerSec; // gesamter x-Versatz in Pixeln seit Start

      double pixelObstacleX;
      // OBSTACLE_1
      pixelObstacleX = xStartObstacle_1 - xDiff;
      obstacleX_1 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_1 < xMAX && obstacleX_1 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_2
      pixelObstacleX = xStartObstacle_2 - xDiff;
      obstacleX_2 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_2 < xMAX && obstacleX_2 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_3
      pixelObstacleX = xStartObstacle_3 - xDiff;
      obstacleX_3 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_3 < xMAX && obstacleX_3 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_4
      pixelObstacleX = xStartObstacle_4 - xDiff;
      obstacleX_4 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_4 < xMAX && obstacleX_4 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_5
      pixelObstacleX = xStartObstacle_5 - xDiff;
      obstacleX_5 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_5 < xMAX && obstacleX_5 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_6
      pixelObstacleX = xStartObstacle_6 - xDiff;
      obstacleX_6 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_6 < xMAX && obstacleX_6 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_7
      pixelObstacleX = xStartObstacle_7 - xDiff;
      obstacleX_7 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_7 < xMAX && obstacleX_7 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_8
      pixelObstacleX = xStartObstacle_8 - xDiff;
      obstacleX_8 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_8 < xMAX && obstacleX_8 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }
      // OBSTACLE_9
      pixelObstacleX = xStartObstacle_9 - xDiff;
      obstacleX_9 = pixelObstacleX / screenWidth * 2 - 1; // Mapping auf -1 bis 1      
      if (obstacleX_9 < xMAX && obstacleX_9 > xMIN && playerY >= 0.35) { // Kollision?
        controller.stop();
        gameOver = true;
        onGameOver();
      }

    }
  }

  void jump() {
    if (playerY == 0.35 && !gameOver) {
      playerY = -0.6;
      Future.delayed(Duration(milliseconds: jumpDurationMs), () {
        playerY = 0.35;
      });
    }
  }

  void dispose() {
    controller.dispose();
  }
}
