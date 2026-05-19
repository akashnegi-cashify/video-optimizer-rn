enum RoleType {
  REPAIR_DEVICE(1),
  DEAD_DEVICE(2),
  ACCEPT_REJECT_DEAD_DEVICE(3);

  final int value;

  const RoleType(this.value);
}

enum DeadDeviceRequestType {
  ACCEPT_DEAD(1),
  REPAIR_REJECT(2),
  REPAIR_DONE(3);

  final int value;

  const DeadDeviceRequestType(this.value);
}
