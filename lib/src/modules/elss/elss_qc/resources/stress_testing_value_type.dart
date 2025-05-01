enum StressTestingValueType {
  failed(-1, "Failed"),
  notApplicable(0, "Not Applicable"),
  passed(1, "Passed");

  final int value;
  final String label;

  const StressTestingValueType(this.value, this.label);

  static StressTestingValueType fromValue(int value) {
    return StressTestingValueType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => StressTestingValueType.notApplicable,
    );
  }
}
