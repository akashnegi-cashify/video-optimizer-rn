enum DocTypeEnum {
  awbInvoice("awb-invoice"),
  packingVideo("packing-video"),
  podImage("pod-image"),
  ewayBill("eway-bill");

  final String value;

  const DocTypeEnum(this.value);
}
