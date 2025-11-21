class Environments {
  static Environment test = Environment(
    appVersion: "5.2.1",
    mode: "prodTest",
    baseUrl: "http://localhost",
    cashifyUrl: "https://www.cashify.in",
    casIdentifier: "qr6y",
    authUri: "/v1/oauth/token",
    apiUrl: "api.cashify.in",
    enableAlice: true,
    sourceIds: SourceIds(android: 20, iOS: 219),
  );

  static Environment stage = Environment(
    appVersion: "5.2.1-stage.1",
    mode: "stage",
    baseUrl: "https://localhost",
    cashifyUrl: "https://www.stage.cashify.in",
    casIdentifier: "cas",
    authUri: "/v1/oauth/token",
    apiUrl: "api.stage.cashify.in",
    enableAlice: true,
    sourceIds: SourceIds(android: 309, iOS: 312),
  );

  static Environment beta = Environment(
    appVersion: "5.2.1-beta.1",
    mode: "beta",
    baseUrl: "http://localhost",
    cashifyUrl: "https://www.beta.cashify.in",
    casIdentifier: "qr6y",
    authUri: "/v1/oauth/token",
    apiUrl: "api.beta.cashify.in",
    enableAlice: true,
    sourceIds: SourceIds(android: 218, iOS: 219),
  );

  static Environment prod = Environment(
    appVersion: "5.2.1",
    mode: "prod",
    baseUrl: "http://localhost",
    cashifyUrl: "https://www.cashify.in",
    casIdentifier: "qr6y",
    authUri: "/v1/oauth/token",
    apiUrl: "api.cashify.in",
    enableAlice: false,
    sourceIds: SourceIds(android: 20, iOS: 219),
  );
}

class SourceIds {
  int? android;
  int? iOS;
  int? web;

  SourceIds({this.android, this.iOS, this.web});
}

class Environment {
  final String? mode;
  final String? baseUrl;
  final String? cashifyUrl;
  final String? casIdentifier;
  final String? authUri;
  final String? apiUrl;
  final String? appVersion;
  final bool? enableAlice;
  final SourceIds? sourceIds;

  Environment({
    this.mode,
    this.baseUrl,
    this.cashifyUrl,
    this.casIdentifier,
    this.authUri,
    this.apiUrl,
    this.appVersion,
    this.enableAlice,
    this.sourceIds,
  });
}
