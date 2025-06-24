import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  int _successCounter = 0; // Zähler für gewonnene Runden

  int get successCounter => _successCounter; // Getter für den Zähler

  void incrementSuccessCounter() {
    _successCounter++; // Erhöhe den Zähler um 1
    notifyListeners(); // Benachrichtige alle Listener, dass sich der Zustand geändert hat
  }

  void resetSuccessCounter() {
    _successCounter = 0; // Setze den Zähler zurück auf 0
    notifyListeners(); // Benachrichtige alle Listener über die Änderung
  }
}