enum ElssPartsSelectionOptions {
  notRequired(-1, "Not Required"),
  repairRequired(1, "Repair Required"),
  serviceRequired(2, "Service Required"),
  optimizationRequired(3, "Optimization Required");

  final int id;
  final String value;

  const ElssPartsSelectionOptions(this.id, this.value);

  static ElssPartsSelectionOptions getEnumById(int? id) {
    var index = ElssPartsSelectionOptions.values.indexWhere((element) => element.id == id);
    if (index > -1) {
      return ElssPartsSelectionOptions.values[index];
    }
    return ElssPartsSelectionOptions.notRequired;
  }

  static ElssPartsSelectionOptions getEnumByValue(String? value) {
    var index = ElssPartsSelectionOptions.values.indexWhere((element) => element.value == value);
    if (index > -1) {
      return ElssPartsSelectionOptions.values[index];
    }
    return ElssPartsSelectionOptions.notRequired;
  }

}
