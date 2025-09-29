enum BarcodeTypes {
  awb(1),
  refNumber(2),
  barcode(3);

  final int value;

  const BarcodeTypes(this.value);
}
