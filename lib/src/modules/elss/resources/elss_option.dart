enum ElssOption {
  ACCEPT(1),
  ACCEPT_FOR_BULK_SALES(2),
  ACCEPT_FOR_WARRANTY(3),
  DECLINE(4),
  SEND_TO_L4(5);

  final int value;

  const ElssOption(this.value);

  static ElssOption? getEnumFromValue(int id) {
    for (var element in ElssOption.values) {
      if (element.value == id) {
        return element;
      }
    }
    return null;
  }

  static String? getOptionName(ElssOption val) {
    switch (val) {
      case ElssOption.ACCEPT:
        return "Accept";
      case ElssOption.ACCEPT_FOR_BULK_SALES:
        return "Accept for Bulk Sales";
      case ElssOption.ACCEPT_FOR_WARRANTY:
        return "Accept for Warranty";
      case ElssOption.DECLINE:
        return "Decline";
      case ElssOption.SEND_TO_L4:
        return "Send to L4";
    }
  }
}
