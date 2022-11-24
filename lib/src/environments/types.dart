enum EnvironmentTypes { TEST, STAGE, BETA, PROD }

extension EnvironmentTypesExtension on EnvironmentTypes {
  get value {
    switch (this) {
      case EnvironmentTypes.TEST:
        return 'test';
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
