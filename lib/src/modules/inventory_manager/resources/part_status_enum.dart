enum PartStatus {
  AVAILABLE(12),
  NOT_AVAILABLE(13),
  OTHER(-1);

  final int value;

  const PartStatus(this.value);

  static PartStatus getEnumByValue(int value) {
    if (value == 12) {
      return PartStatus.AVAILABLE;
    }
    if (value == 13) {
      return PartStatus.NOT_AVAILABLE;
    }
    return PartStatus.OTHER;
  }
}
