enum PartStatus {
  AVAILABLE(12),
  NOT_AVAILABLE(13),
  OTHER(-1);

  final int value;

  const PartStatus(this.value);

  static PartStatus getEnumByValue(int value) {
    int index = PartStatus.values.indexWhere((element) => element.value == value);
    if (index > -1 ) {
      return PartStatus.values[index];
    }
    return PartStatus.OTHER;
  }
}
