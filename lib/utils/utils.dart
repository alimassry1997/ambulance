import 'package:encrypt/encrypt.dart';

int timeStampNow() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

String encryptString(String text) {
  final key = Key.fromUtf8('ambulancecheckup');
  final iv = IV.fromUtf8('0123456789ABCDEF'); // Fixed IV

  final encrypter = Encrypter(AES(key)); // Create an AES encrypter

  final encrypted = encrypter.encrypt(text, iv: iv); // Encrypt the text

  return encrypted.base64; // Return the base64 encoded encrypted string
}
