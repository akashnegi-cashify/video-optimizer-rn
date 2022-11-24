enum OTPNotificationType {
  SMS('sms'),
  IVR('ivr');

  final String value;
  const OTPNotificationType(this.value);
}

abstract class CommonConstant {
  static const String KEY_SELECTED_LANGUAGE = "code";
}
