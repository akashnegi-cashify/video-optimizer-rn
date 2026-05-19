import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/environments/environments.dart';

/// Tests for Environments, Environment, and SourceIds classes.
/// Focus: Testing environment configurations and model properties.
void main() {
  group('Environment', () {
    group('constructor', () {
      test('should create Environment with all parameters', () {
        final sourceIds = SourceIds(android: 1, iOS: 2, web: 3);
        final environment = Environment(
          mode: 'test',
          baseUrl: 'http://localhost',
          cashifyUrl: 'https://cashify.in',
          casIdentifier: 'cas123',
          authUri: '/auth',
          apiUrl: 'api.test.com',
          appVersion: '1.0.0',
          enableAlice: true,
          sourceIds: sourceIds,
        );

        expect(environment.mode, 'test');
        expect(environment.baseUrl, 'http://localhost');
        expect(environment.cashifyUrl, 'https://cashify.in');
        expect(environment.casIdentifier, 'cas123');
        expect(environment.authUri, '/auth');
        expect(environment.apiUrl, 'api.test.com');
        expect(environment.appVersion, '1.0.0');
        expect(environment.enableAlice, true);
        expect(environment.sourceIds, sourceIds);
      });

      test('should create Environment with null parameters', () {
        final environment = Environment();

        expect(environment.mode, isNull);
        expect(environment.baseUrl, isNull);
        expect(environment.cashifyUrl, isNull);
        expect(environment.casIdentifier, isNull);
        expect(environment.authUri, isNull);
        expect(environment.apiUrl, isNull);
        expect(environment.appVersion, isNull);
        expect(environment.enableAlice, isNull);
        expect(environment.sourceIds, isNull);
      });

      test('should create Environment with partial parameters', () {
        final environment = Environment(
          mode: 'partial',
          apiUrl: 'api.partial.com',
        );

        expect(environment.mode, 'partial');
        expect(environment.apiUrl, 'api.partial.com');
        expect(environment.baseUrl, isNull);
        expect(environment.enableAlice, isNull);
      });
    });
  });

  group('SourceIds', () {
    group('constructor', () {
      test('should create SourceIds with all parameters', () {
        final sourceIds = SourceIds(android: 10, iOS: 20, web: 30);

        expect(sourceIds.android, 10);
        expect(sourceIds.iOS, 20);
        expect(sourceIds.web, 30);
      });

      test('should create SourceIds with null parameters', () {
        final sourceIds = SourceIds();

        expect(sourceIds.android, isNull);
        expect(sourceIds.iOS, isNull);
        expect(sourceIds.web, isNull);
      });

      test('should create SourceIds with partial parameters', () {
        final sourceIds = SourceIds(android: 5);

        expect(sourceIds.android, 5);
        expect(sourceIds.iOS, isNull);
        expect(sourceIds.web, isNull);
      });
    });
  });

  group('Environments', () {
    group('test environment', () {
      test('should have correct mode', () {
        expect(Environments.test.mode, 'prodTest');
      });

      test('should have correct baseUrl', () {
        expect(Environments.test.baseUrl, 'http://localhost');
      });

      test('should have correct cashifyUrl', () {
        expect(Environments.test.cashifyUrl, 'https://www.cashify.in');
      });

      test('should have correct casIdentifier', () {
        expect(Environments.test.casIdentifier, 'qr6y');
      });

      test('should have correct authUri', () {
        expect(Environments.test.authUri, '/v1/oauth/token');
      });

      test('should have correct apiUrl', () {
        expect(Environments.test.apiUrl, 'api.cashify.in');
      });

      test('should have enableAlice set to true', () {
        expect(Environments.test.enableAlice, true);
      });

      test('should have correct source IDs', () {
        expect(Environments.test.sourceIds?.android, 20);
        expect(Environments.test.sourceIds?.iOS, 219);
      });
    });

    group('stage environment', () {
      test('should have correct mode', () {
        expect(Environments.stage.mode, 'stage');
      });

      test('should have correct cashifyUrl', () {
        expect(Environments.stage.cashifyUrl, 'https://www.stage.cashify.in');
      });

      test('should have correct casIdentifier', () {
        expect(Environments.stage.casIdentifier, 'cas');
      });

      test('should have correct apiUrl', () {
        expect(Environments.stage.apiUrl, 'api.stage.cashify.in');
      });

      test('should have enableAlice set to true', () {
        expect(Environments.stage.enableAlice, true);
      });

      test('should have correct source IDs', () {
        expect(Environments.stage.sourceIds?.android, 309);
        expect(Environments.stage.sourceIds?.iOS, 312);
      });
    });

    group('beta environment', () {
      test('should have correct mode', () {
        expect(Environments.beta.mode, 'beta');
      });

      test('should have correct cashifyUrl', () {
        expect(Environments.beta.cashifyUrl, 'https://www.beta.cashify.in');
      });

      test('should have correct apiUrl', () {
        expect(Environments.beta.apiUrl, 'api.beta.cashify.in');
      });

      test('should have enableAlice set to true', () {
        expect(Environments.beta.enableAlice, true);
      });

      test('should have correct source IDs', () {
        expect(Environments.beta.sourceIds?.android, 218);
        expect(Environments.beta.sourceIds?.iOS, 219);
      });
    });

    group('prod environment', () {
      test('should have correct mode', () {
        expect(Environments.prod.mode, 'prod');
      });

      test('should have correct cashifyUrl', () {
        expect(Environments.prod.cashifyUrl, 'https://www.cashify.in');
      });

      test('should have correct apiUrl', () {
        expect(Environments.prod.apiUrl, 'api.cashify.in');
      });

      test('should have enableAlice set to false', () {
        expect(Environments.prod.enableAlice, false);
      });

      test('should have correct source IDs', () {
        expect(Environments.prod.sourceIds?.android, 20);
        expect(Environments.prod.sourceIds?.iOS, 219);
      });
    });

    group('environment differentiation', () {
      test('all environments should have different modes', () {
        final modes = [
          Environments.test.mode,
          Environments.stage.mode,
          Environments.beta.mode,
          Environments.prod.mode,
        ];
        expect(modes.toSet().length, 4);
      });

      test('only prod should have Alice disabled', () {
        expect(Environments.test.enableAlice, true);
        expect(Environments.stage.enableAlice, true);
        expect(Environments.beta.enableAlice, true);
        expect(Environments.prod.enableAlice, false);
      });

      test('all environments should have auth URI set', () {
        expect(Environments.test.authUri, isNotNull);
        expect(Environments.stage.authUri, isNotNull);
        expect(Environments.beta.authUri, isNotNull);
        expect(Environments.prod.authUri, isNotNull);
      });

      test('all environments should have same auth URI path', () {
        expect(Environments.test.authUri, '/v1/oauth/token');
        expect(Environments.stage.authUri, '/v1/oauth/token');
        expect(Environments.beta.authUri, '/v1/oauth/token');
        expect(Environments.prod.authUri, '/v1/oauth/token');
      });
    });
  });
}
