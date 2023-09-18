enum EngineerDeviceActionStatusEnum {
  MARK_IN_PROGRESS("mark-inprogress"),
  MARK_OK("mark-ok"),
  MARK_REPAIR_DONE("mark-repair-done"),
  MARK_FI("mark-fi"),
  MARK_NFF("mark-nff"),
  MARK_NR("mark-nr"),
  MARK_ON_HOLD("mark-onhold");

  final String value;

  const EngineerDeviceActionStatusEnum(this.value);
}
