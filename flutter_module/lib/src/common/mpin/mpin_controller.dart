class MPinController {
  static bool isConsecutive(String numbers) {
    if (numbers.isEmpty || numbers.length == 1) return true;

    if (!RegExp(r'^\d+$').hasMatch(numbers)) return false;

    List<int> digits = numbers.split('').map((e) => int.parse(e)).toList();

    bool isAscending = digits[1] > digits[0];

    for (int i = 0; i < digits.length - 1; i++) {
      if (isAscending) {
        if (digits[i + 1] - digits[i] != 1) return false;
      } else {
        if (digits[i] - digits[i + 1] != 1) return false;
      }
    }
    return true;
  }

  static bool isRepetitive(String numbers) {
    if (numbers.isEmpty || numbers.length == 1) return true;
    if (!RegExp(r'^\d+$').hasMatch(numbers)) return false;

    List<int> digits = numbers.split('').map((e) => int.parse(e)).toList();

    for (int i = 0; i < digits.length - 1; i++) {
      if (digits[i + 1] - digits[i] != 0) return false;
    }
    return true;
  }
}
