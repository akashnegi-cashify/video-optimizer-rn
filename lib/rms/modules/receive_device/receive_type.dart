enum ReceiveType {
  internal(1),
  reverse(2),
  customerRoutedToStore(3);

  final int value;

  const ReceiveType(this.value);


static ReceiveType fromValue(int value) {
    switch (value) {
      case 1:
        return ReceiveType.internal;
      case 2:
        return ReceiveType.reverse;
      case 3:
        return ReceiveType.customerRoutedToStore;
      default:
        throw ArgumentError('Invalid value');
    }
  }
}
