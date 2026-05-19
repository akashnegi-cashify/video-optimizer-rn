enum LotReQcStatusType {
  REJECT(-1),
  MATCH(0),
  MIS_MATCH(1),
  MANUAL_MATCH(2);

  final int value;

  const LotReQcStatusType(this.value);
}
