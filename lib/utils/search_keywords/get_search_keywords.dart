
import 'package:diacritic/diacritic.dart';

class SearchKeywords{
  static String get(String input){
    final regExSigns = RegExp(r'[^\w\sáéíóúüñÁÉÍÓÚÜÑ]');
    final regExWhiteChars = RegExp(r'(\r\n|\n|\r)');
    final fullStr = input;
    final str1 = fullStr.replaceAll(regExSigns, '');
    final words = str1.replaceAll(regExWhiteChars, ' ');
    final normalizedWords = words.split(' ').map(
      (e) => removeDiacritics(e.toLowerCase())
    ).toList(); 
    final result = normalizedWords.toSet().join(' ');
    return result;
  }
}