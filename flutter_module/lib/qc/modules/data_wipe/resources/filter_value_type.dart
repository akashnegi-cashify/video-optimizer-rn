enum FilterValueType {
  singleSelect(1),
  multiSelect(2);

  final int value;

  const FilterValueType(this.value);

  static FilterValueType findTypeByValue(int value) {
    return FilterValueType.values.firstWhere((element) => element.value == value);
  }
}
