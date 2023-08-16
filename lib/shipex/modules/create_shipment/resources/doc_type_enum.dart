enum DocTypeEnum {
  awbInvoice("awb-invoice"),
  packageVideo("package-video"),
  podImage("pod-image"),
  ewayBill("eway-bill");

  final String value;

  const DocTypeEnum(this.value);
}
