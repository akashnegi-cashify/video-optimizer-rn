class AppHeaders {
  static const String X_APP_INSTALLER_KEY = 'x-app-installer';
  static const String X_APP_REFERRAL_KEY = 'x-app-referral';
  static const String X_USER_AUTH_KEY = 'x-user-auth';
  static const String X_APP_KEY_CONTENT_TYPE = 'content-type';
  static const String X_SUPER_SALE_BACKEND_AUTH_KEY = 'super-sales-backend-auth';
  static const String X_APP_OS_KEY = 'x-app-os';
  static const String X_APP_LANGUAGE_KEY = 'x-app-lang';
  static const String X_APP_VERSION_KEY = 'x-app-version';

  static const Map<String, String> X_USER_AUTH = {X_USER_AUTH_KEY: 'true'};
  static const Map<String, String> X_APP_INSTALLER = {X_APP_INSTALLER_KEY: X_APP_VALUE};
  static const Map<String, String> X_APP_CONTENT_TYPE = {X_APP_KEY_CONTENT_TYPE: X_CONTENT_TYPE};
  static const Map<String, String> X_APP_REFERRAL = {X_APP_REFERRAL_KEY: 'true'};

  static const String installer = 'cashifyapp';
  static const String X_APP_VALUE = "CashifyTrcApp";
  static const String X_CONTENT_TYPE = "application/json";
}
