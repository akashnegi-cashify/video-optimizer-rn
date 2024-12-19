enum DataWipeStatus {
  init,
  success,
  error;

  static DataWipeStatus getStatus(int? statusCode) {
    if ((statusCode ?? 0) < 0) {
      return DataWipeStatus.error;
    } else if (statusCode == 44) {
      return DataWipeStatus.success;
    } else {
      return DataWipeStatus.init;
    }
  }
}
