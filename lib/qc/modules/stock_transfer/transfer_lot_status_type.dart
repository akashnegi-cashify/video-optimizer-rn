enum TransferLotStatusType {
  NEW(0, "New"),
  IN_PROCESS(1, "In progress"),
  LOCKED(2, "Lock"),
  APPROVE(3, "Approve"),
  DISPATCH(4, "Dispatch"),
  REJECT(5, "Reject"),
  RECEIVE(6, "Receive"),
  BULK_RECEIVE_INIT(67, "Bulk Receive Init"),
  COMPLETE(7, "Complete"),
  STORE_OUT_PENDING(8, "Store Out Pending"),
  READY_TO_SHIP(9, "Ready To Ship"),
  DELETE(-1, "Delete");

  final int code;
  final String name;

  const TransferLotStatusType(this.code, this.name);
}
