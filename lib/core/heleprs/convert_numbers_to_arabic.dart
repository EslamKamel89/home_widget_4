String convertNumberToArabic(String number) {
  List<String> arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  String arabicNumber = number.split('').map((char) {
    if (RegExp(r'\d').hasMatch(char)) {
      return arabicNumbers[int.parse(char)];
    }
    return char;
  }).join('');

  return arabicNumber;
}
