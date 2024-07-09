enum ReceiveType {
  internal(1),
  reverse(2),
  customerRoutedToStore(3);

  final int value;

  const ReceiveType(this.value);
}
