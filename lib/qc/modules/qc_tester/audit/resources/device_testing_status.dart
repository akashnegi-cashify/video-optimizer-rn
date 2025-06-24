enum DeviceTestingErrorStatus {
  markOkPass(8001), // TODO: need to verify this code
  markOkFail(8002),
  none(-1);

  final int code;

  const DeviceTestingErrorStatus(this.code);

  static DeviceTestingErrorStatus? fromCode(int? code) {
    return DeviceTestingErrorStatus.values
        .firstWhere((e) => e.code == code, orElse: () => DeviceTestingErrorStatus.none);
  }
}
