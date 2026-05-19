enum JourneyType {
  generic,
  testing,
  audit;

  bool get isTesting => this == JourneyType.testing;
  bool get isAudit => this == JourneyType.audit;
  bool get isGeneric => this == JourneyType.generic;

}
