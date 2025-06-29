import 'dart:math';
import 'package:projects/library.dart';

enum Language { english, spanish }

class QuoteLibrary {
  static List<String> getAlphabet(Language language) {
    if (language == Language.spanish) {
      return 'abcdefghijklmnopqrstuvwxyzñ'.toUpperCase().split('');
    }
    return 'abcdefghijklmnopqrstuvwxyz'.toUpperCase().split('');
  }

  //takes in a single character
  static bool isException(String i, Language language) {
    return !getAlphabet(language).contains(i.toUpperCase());
  }

  static Map<String, String> generateKey(String text, Language language) {
    var alphabet = getAlphabet(language);
    var shuffled = List<String>.from(alphabet);
    final rand = Random();
    // Fisher-Yates shuffle
    for (int i = shuffled.length - 1; i > 0; i--) {
      int j = rand.nextInt(i + 1);
      var temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }
    // Ensure no letter maps to itself (derangement)
    for (int i = 0; i < alphabet.length; i++) {
      if (shuffled[i] == alphabet[i]) {
        int swapWith = (i == alphabet.length - 1) ? i - 1 : i + 1;
        var temp = shuffled[i];
        shuffled[i] = shuffled[swapWith];
        shuffled[swapWith] = temp;
      }
    }
    // Create a mapping from original alphabet to shuffled alphabet
    Map<String, String> tempKey = {};
    for (int i = 0; i < alphabet.length; i++) {
      tempKey[alphabet[i]] = shuffled[i];
    }
    // Map non-alphabet characters to themselves
    for (String i in text.split('')) {
      if (!alphabet.contains(i)) tempKey[i] = i;
    }
    return tempKey;
  }

  static String generateCipherText(String text, Map<String, String> tempKey) {
    String ans = "";
    for (String i in text.split('')) {
      ans += tempKey[i]!;
    }
    return ans;
  }

  static Map<String, int> getFrequencies(String text) {
    final Map<String, int> tempFrequencies = {};
    for (var char in text.split('')) {
      tempFrequencies[char] = (tempFrequencies[char] ?? 0) + 1;
    }
    return tempFrequencies;
  }

  //add functional quotes
  static Quote getNewQuote(Language language) {
    String tempOgQuote;
    if (language == Language.spanish) {
      tempOgQuote =
          "*Hola como estas? Espero que estes bien. Este es un ejemplo de cita en español para probar el sistema. Necesito mas palabras para llenar espacio, asi que eso es lo que estoy haciendo. Parece que necesito aun mas palabras. ¿Es esto suficiente? Supongo que solo hay una manera de averiguarlo...";
    } else {
      tempOgQuote =
          "*hello, world! What a wonderful time to be alive. Don't you think so? I need some more words to fill space so that is what this is. Looks like I need even more words. Is this enough? I guess there's only one way to find out...";
    }
    String tempPlainText = tempOgQuote.toUpperCase();
    Map<String, String> tempKey = generateKey(tempPlainText, language);
    String tempCipherText = generateCipherText(tempPlainText, tempKey);
    Map<String, int> tempFrequencies = getFrequencies(tempPlainText);
    return Quote(
      ogQuote: tempOgQuote,
      plainText: tempPlainText,
      key: tempKey,
      cipherText: tempCipherText,
      frequencies: tempFrequencies,
    );
  }
}
