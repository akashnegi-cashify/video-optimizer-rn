enum StorageType {
  appStorage("lego_shared"),
  qcStorage("QcStorage"),
  rmsStorage("RmsStorage"),
  trcStorage("TrcStorage");

  final String value;

  const StorageType(this.value);
}
