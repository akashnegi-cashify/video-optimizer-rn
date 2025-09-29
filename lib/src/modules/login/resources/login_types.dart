enum LoginTypes {
  trcLogin("TRC"),
  qcLogin("QC"),
  shipexLogin("Shipex"),
  rmsLogin("RMS");

  final String value;

  const LoginTypes(this.value);

  static LoginTypes fromValue(String value) {
    LoginTypes loginTypes =
        LoginTypes.values.firstWhere((element) => element.value == value, orElse: () => LoginTypes.qcLogin);
    return loginTypes;
  }
}
