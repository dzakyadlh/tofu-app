import 'dart:convert';

import 'package:crypto/crypto.dart';

class PinEncryption {
  String hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final hash = sha256.convert(bytes);
    return hash.toString(); // Store this in Firestore for comparison
  }

  // Verifies if the entered PIN matches the stored hash
  bool verifyPin(String enteredPin, String storedHash) {
    final hashedEnteredPin = hashPin(enteredPin);
    return hashedEnteredPin == storedHash;
  }
}
