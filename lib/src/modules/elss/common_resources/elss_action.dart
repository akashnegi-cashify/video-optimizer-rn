enum ElssAction {
  REPAIRABLE("Required"),
  NOT_REPAIRABLE("Not Repairable"),
  NOT_REQUIRED("Not Required"),
  REPAIRABLE_SERVER("Repairable");

  final String value;

  const ElssAction(this.value);

  static ElssAction? getActionByValue(String data) {
    for (var item in ElssAction.values) {
      if (item.value == data) {
        return item;
      }
    }
    return null;
  }
}
