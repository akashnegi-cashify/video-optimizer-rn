enum EnvironmentTypes { PROD_TEST, STAGE, BETA, PROD }

extension EnvironmentTypesExtension on EnvironmentTypes {
  get value {
    switch (this) {
      case EnvironmentTypes.PROD_TEST:
        return 'prodTest';
      case EnvironmentTypes.STAGE:
        return 'stage';
      case EnvironmentTypes.BETA:
        return 'beta';
      case EnvironmentTypes.PROD:
        return 'prod';
      default:
        return 'stage';
    }
  }
}
