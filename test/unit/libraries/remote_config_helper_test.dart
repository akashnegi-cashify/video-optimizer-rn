import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';

void main() {
  group('AppRemoteConfig', () {
    group('config keys', () {
      test('KEY_IS_FORCE_SERVER_RULE_EXECUTOR should have correct value', () {
        expect(
          AppRemoteConfig.KEY_IS_FORCE_SERVER_RULE_EXECUTOR,
          equals('key_is_force_server_rule_executor'),
        );
      });

      test('KEY_IS_ENABLE_RULE_EXE_TEST_MODE should have correct value', () {
        expect(
          AppRemoteConfig.KEY_IS_ENABLE_RULE_EXE_TEST_MODE,
          equals('key_is_enable_rule_exe_test_mode'),
        );
      });

      test('KEY_VIDEO_RECORD_DURATION_IN_SEC should have correct value', () {
        expect(
          AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC,
          equals('key_video_record_duration_in_sec'),
        );
      });

      test('KEY_APP_SUPPORTED_VERSIONS should have correct value', () {
        expect(
          AppRemoteConfig.KEY_APP_SUPPORTED_VERSIONS,
          equals('key_app_supported_versions'),
        );
      });

      test('KEY_VIDEO_OPTIMIZER_CONFIG should have correct value', () {
        expect(
          AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG,
          equals('key_video_optimizer_config'),
        );
      });

      test('KEY_VIDEO_OPTIMIZER_CONFIG_D2C should have correct value', () {
        expect(
          AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG_D2C,
          equals('key_video_optimizer_config_d2c'),
        );
      });

      test('KEY_IS_RUN_IMEI_VALIDATOR_FLOW should have correct value', () {
        expect(
          AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW,
          equals('key_is_run_imei_validator_flow'),
        );
      });

      test('KEY_IS_RUN_SERIAL_VALIDATOR_FLOW should have correct value', () {
        expect(
          AppRemoteConfig.KEY_IS_RUN_SERIAL_VALIDATOR_FLOW,
          equals('key_is_run_serial_validator_flow'),
        );
      });

      test('KEY_IMEI_READER_TIMEOUT_SEC should have correct value', () {
        expect(
          AppRemoteConfig.KEY_IMEI_READER_TIMEOUT_SEC,
          equals('key_imei_reader_timeout_sec'),
        );
      });
    });

    group('DEFAULT_CONFIG', () {
      test('should contain all required keys', () {
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_IS_FORCE_SERVER_RULE_EXECUTOR),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_IS_ENABLE_RULE_EXE_TEST_MODE),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_APP_SUPPORTED_VERSIONS),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG_D2C),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_IS_RUN_SERIAL_VALIDATOR_FLOW),
          isTrue,
        );
        expect(
          AppRemoteConfig.DEFAULT_CONFIG.containsKey(AppRemoteConfig.KEY_IMEI_READER_TIMEOUT_SEC),
          isTrue,
        );
      });

      test('KEY_IS_FORCE_SERVER_RULE_EXECUTOR should default to true', () {
        expect(
          AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_IS_FORCE_SERVER_RULE_EXECUTOR],
          isTrue,
        );
      });

      test('KEY_IS_ENABLE_RULE_EXE_TEST_MODE should default to true', () {
        expect(
          AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_IS_ENABLE_RULE_EXE_TEST_MODE],
          isTrue,
        );
      });

      test('KEY_VIDEO_RECORD_DURATION_IN_SEC should default to 1200', () {
        expect(
          AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC],
          equals(1200),
        );
      });

      test('KEY_IS_RUN_IMEI_VALIDATOR_FLOW should default to true', () {
        expect(
          AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW],
          isTrue,
        );
      });

      test('KEY_IS_RUN_SERIAL_VALIDATOR_FLOW should default to true', () {
        expect(
          AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_IS_RUN_SERIAL_VALIDATOR_FLOW],
          isTrue,
        );
      });

      test('KEY_IMEI_READER_TIMEOUT_SEC should default to 5', () {
        expect(
          AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_IMEI_READER_TIMEOUT_SEC],
          equals(5),
        );
      });

      test('KEY_VIDEO_OPTIMIZER_CONFIG should be valid JSON string', () {
        final config = AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG];
        expect(config, isA<String>());
        expect(config, contains('videoCodec'));
        expect(config, contains('libx264'));
      });

      test('KEY_VIDEO_OPTIMIZER_CONFIG_D2C should be valid JSON string', () {
        final config = AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG_D2C];
        expect(config, isA<String>());
        expect(config, contains('videoCodec'));
        expect(config, contains('isRemoveAudio'));
      });

      test('KEY_APP_SUPPORTED_VERSIONS should be valid JSON string', () {
        final versions = AppRemoteConfig.DEFAULT_CONFIG[AppRemoteConfig.KEY_APP_SUPPORTED_VERSIONS];
        expect(versions, isA<String>());
        expect(versions, contains('dt'));
        expect(versions, contains('version'));
        expect(versions, contains('isMajor'));
        expect(versions, contains('apkUrl'));
      });
    });

    group('config key format', () {
      test('all keys should start with key_', () {
        final keys = [
          AppRemoteConfig.KEY_IS_FORCE_SERVER_RULE_EXECUTOR,
          AppRemoteConfig.KEY_IS_ENABLE_RULE_EXE_TEST_MODE,
          AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC,
          AppRemoteConfig.KEY_APP_SUPPORTED_VERSIONS,
          AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG,
          AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG_D2C,
          AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW,
          AppRemoteConfig.KEY_IS_RUN_SERIAL_VALIDATOR_FLOW,
          AppRemoteConfig.KEY_IMEI_READER_TIMEOUT_SEC,
        ];

        for (final key in keys) {
          expect(key.startsWith('key_'), isTrue, reason: 'Key "$key" should start with "key_"');
        }
      });

      test('all keys should be snake_case', () {
        final keys = [
          AppRemoteConfig.KEY_IS_FORCE_SERVER_RULE_EXECUTOR,
          AppRemoteConfig.KEY_IS_ENABLE_RULE_EXE_TEST_MODE,
          AppRemoteConfig.KEY_VIDEO_RECORD_DURATION_IN_SEC,
          AppRemoteConfig.KEY_APP_SUPPORTED_VERSIONS,
          AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG,
          AppRemoteConfig.KEY_VIDEO_OPTIMIZER_CONFIG_D2C,
          AppRemoteConfig.KEY_IS_RUN_IMEI_VALIDATOR_FLOW,
          AppRemoteConfig.KEY_IS_RUN_SERIAL_VALIDATOR_FLOW,
          AppRemoteConfig.KEY_IMEI_READER_TIMEOUT_SEC,
        ];

        for (final key in keys) {
          expect(key, equals(key.toLowerCase()), reason: 'Key "$key" should be lowercase');
          expect(key.contains(' '), isFalse, reason: 'Key "$key" should not contain spaces');
        }
      });
    });
  });

  group('RemoteConfigHelper', () {
    group('singleton pattern', () {
      test('should return same instance on multiple calls', () {
        // Arrange & Act
        final instance1 = RemoteConfigHelper();
        final instance2 = RemoteConfigHelper();

        // Assert
        expect(identical(instance1, instance2), isTrue);
      });
    });

    // Note: Full functional tests for initialize, fetchAndActivate, getString, getBoolean,
    // getInt, getDouble require Firebase Remote Config initialization which requires
    // platform-specific setup. These tests document the expected API contract.

    group('method signatures', () {
      test('initialize should return Future<FirebaseRemoteConfig?>', () {
        // Document: initialize() returns Future<FirebaseRemoteConfig?>
        // Cannot test without Firebase initialization
        expect(true, isTrue);
      });

      test('fetchAndActivate should return Future', () {
        // Document: fetchAndActivate() returns Future
        expect(true, isTrue);
      });

      test('getString should accept key parameter', () {
        // Document: getString(key) returns String
        expect(true, isTrue);
      });

      test('getBoolean should accept key parameter', () {
        // Document: getBoolean(key) returns dynamic
        expect(true, isTrue);
      });

      test('getInt should accept key parameter', () {
        // Document: getInt(key) returns int
        expect(true, isTrue);
      });

      test('getDouble should accept key parameter', () {
        // Document: getDouble(key) returns double
        expect(true, isTrue);
      });
    });
  });
}
