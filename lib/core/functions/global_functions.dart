abstract class GlFunctions {
  static String sortPhoneNumbers(String firstNumber, secondNumber) {
    List<String> result = [firstNumber, secondNumber]..sort();

    return result.join('-');
  }
}
