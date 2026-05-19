import 'package:core/core.dart';
import 'package:flutter_trc/src/environments/types.dart';
import '../app_initializer.dart';
import '../utils/app_util.dart';
import 'environments.dart';

Environment? environment;

initEnvironment() {
  environment = getEnvironment();
}

Environment getEnvironment() {
  const String envName = RUNNING_SYSTEM_ENV;
  if (EnvironmentTypes.PROD_TEST.value == envName) {
    return Environments.test;
  } else if (EnvironmentTypes.STAGE.value == envName) {
    return Environments.stage;
  } else if (EnvironmentTypes.BETA.value == envName) {
    return Environments.beta;
  } else if (EnvironmentTypes.PROD.value == envName) {
    return Environments.prod;
  } else {
    return Environments.stage;
  }
}

String? addAuthUriQueryParams(String? authUri) {
  if (authUri == null) {
    return authUri;
  }
  String? clientId = getClientId();
  if (clientId == null) {
    return authUri;
  }
  return '$authUri?client_id=$clientId&client_version=$CLIENT_VERSION&grant_type=implicit';
}

String getAuthUrl(Environment environment) {
  String authUri = addAuthUriQueryParams(environment.authUri)!;
  return buildUrl(
    true,
    true,
    environment.casIdentifier!,
    authUri,
    environment.apiUrl!,
  );
}
