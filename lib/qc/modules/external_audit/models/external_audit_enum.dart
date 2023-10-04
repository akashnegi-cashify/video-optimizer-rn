enum ExternalAuditEnum {
  receiveStock(0),
  receiveReturn(0),
  dispatch(1);

  final int val;

  const ExternalAuditEnum(this.val);
}
