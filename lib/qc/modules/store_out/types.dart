enum LotType {
  NORMAL_LOT(1),
  BIN_LOT(2),
  BIN_OUT_LOT(3);

  final int value;

  const LotType(this.value);

  static bool isValid(int? type) {
    return type == null ? false : values.any((element) => element.value == type);
  }
}
