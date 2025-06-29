class Quote {
  final String ogQuote;
  final String cipherText; //should be uppercase
  final String plainText; //should be uppercase
  final Map<String, int> frequencies; // of plainText
  final Map<String, String> key; //plainText -> cipherText

  Quote({
    this.ogQuote = "",
    this.cipherText = "",
    this.plainText = "",
    this.frequencies = const {},
    this.key = const {},
  });
}
