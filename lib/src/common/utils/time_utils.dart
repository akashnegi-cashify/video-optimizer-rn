import 'package:intl/intl.dart';

extension TimeUtils on int {
  String formatInReadableTimeDiff() {
    int seconds = ((this / 1000) % 60).toInt();
    int minutes = ((this / (1000 * 60)) % 60).toInt();
    int hours = ((this / (1000 * 60 * 60)) % 24).toInt();

    String time = "";
    if (hours != 0) {
      time = "$time$hours Hours ";
    }
    if (minutes != 0) {
      time = "$time$minutes Minutes ";
    }
    return "$time$seconds Seconds";
  }
}

extension DateTimeFormat on DateTime {
  /// Operation on DateTime
  /// Returns Date string in format dd/MM/yyyy
  String formatToSimpleDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

DateTime previousNthDayStart(int nDays) {
  DateTime previousNthDayDateTime = DateTime.now().subtract(Duration(days: nDays));
  return DateTime(previousNthDayDateTime.year, previousNthDayDateTime.month, previousNthDayDateTime.day);
}

DateTime previousNthDayEnd(int nDays) {
  DateTime previousNthDayDateTime = DateTime.now().subtract(Duration(days: nDays));
  return DateTime(previousNthDayDateTime.year, previousNthDayDateTime.month, previousNthDayDateTime.day)
      .add(const Duration(hours: 23, minutes: 59, seconds: 59));
}

DateTime thisMonthStart() {
  DateTime currentDateTime = DateTime.now();
  return DateTime(currentDateTime.year, currentDateTime.month, 1);
}

DateTime lastMonthStart() {
  DateTime currentDateTime = DateTime.now();
  return DateTime(currentDateTime.year, currentDateTime.month - 1, 1);
}

DateTime lastMonthEnd() {
  DateTime currentDateTime = DateTime.now();
  return DateTime(currentDateTime.year, currentDateTime.month).subtract(const Duration(seconds: 1));
}

