import 'package:flame/game.dart';
import 'background_component.dart'; // Importiere den BackgroundComponent

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(BackgroundComponent()); // Füge den Hintergrund hinzu
  }
}