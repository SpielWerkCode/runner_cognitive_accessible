import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class BackgroundComponent extends Component with HasGameRef {
  late SpriteComponent bg1;
  late SpriteComponent bg2;
  late double totalWidth;
  late double image1Width;
  late double image2Width;
  double bgTime = 9.2; // Sekunde für Durchlauf eines Hintergrundbildes
  late double scaledWidth1;
  late double scaledWidth2;
  late double startTime;  // Startzeit speichern

  @override
  Future<void> onLoad() async {
    // Lade die Bilder
    final image1 = await Flame.images.load('image_bg.png');
    final image2 = await Flame.images.load('image_bg_2.png');

    // Ursprüngliche Breiten der Bilder
    image1Width = image1.width.toDouble();
    image2Width = image2.width.toDouble();

    // Bildschirmhöhe
    double screenHeight = gameRef.size.y;

    // Berechne die Skalierungsfaktoren, um die Bildschirmhöhe abzudecken
    double scale1 = screenHeight / image1.height;
    double scale2 = screenHeight / image2.height;

    // Berechne die skalierten Breiten
    scaledWidth1 = image1Width * scale1;
    scaledWidth2 = image2Width * scale2;

    // Berechne die Gesamtbreite der beiden Bilder
    totalWidth = scaledWidth1 + scaledWidth2;

    // Erstelle Sprite-Komponenten für die beiden Bilder mit angepasster Größe
    bg1 = SpriteComponent()
      ..sprite = Sprite(image1)
      ..size = Vector2(scaledWidth1, screenHeight)
      ..position = Vector2(0, 0);

    bg2 = SpriteComponent()
      ..sprite = Sprite(image2)
      ..size = Vector2(scaledWidth2, screenHeight)
      ..position = Vector2(scaledWidth1, 0); // Startet direkt neben bg1

    add(bg1);
    add(bg2);

    // Speichere die Startzeit, wenn das Hintergrundelement geladen wird
    startTime = DateTime.now().millisecondsSinceEpoch.toDouble();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Berechne die verstrichene Zeit (in Sekunden)
    double currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
    double diffTime = (currentTime - startTime) / 1000;  // diffTime in Sekunden
    //print('BG Verstrichene Zeit: $diffTime Sekunden');
    // Sägezahn-Kurve: Berechne xPos1
    double cycleTime = diffTime % (2*bgTime); // Zeit innerhalb eines 12-Sekunden-Zyklus
    double xPos1;
    double xPos2;
    if (cycleTime < bgTime) {
      xPos1 = 0 - (100 * (cycleTime / bgTime)); // von +0 zu -100
    } else {
      xPos1 = 100 - (100 * ((cycleTime - bgTime) / bgTime)); // von +100 zu -100
    }
    //print('xPos1: $xPos1');
    xPos2 = xPos1 + 100;
    if (xPos2 > 100) {
      xPos2 = xPos2 -200;
    }
    //print('xPos2: $xPos2');

    // Prozent-x-Positionen auf Pixel umrechnen
    bg1.position.x = xPos1/100 * scaledWidth1;
    bg2.position.x = xPos2/100 * scaledWidth2;
  }
}
