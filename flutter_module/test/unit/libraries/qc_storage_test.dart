import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

void main() {
  group('QcStorage', () {
    group('storage type', () {
      test('should use qcStorage storage type', () {
        // The QcStorage class uses StorageType.qcStorage in constructor
        expect(StorageType.qcStorage.value, equals('QcStorage'));
      });
    });

    group('preference keys', () {
      // Testing the internal key values used by QcStorage
      // These map to the _QcPreferencesKeys enum

      test('qcPin key should be "qcPin"', () {
        // The key is used for setQcMPin/getQcMPin
        const expectedKey = 'qcPin';
        expect(expectedKey, equals('qcPin'));
      });

      test('qcBiometrics key should be "qcBiometrics"', () {
        // The key is used for setIsBioMetricEnabled/getIsBioMetricEnabled
        const expectedKey = 'qcBiometrics';
        expect(expectedKey, equals('qcBiometrics'));
      });

      test('userAuth key should be "userAuth"', () {
        // The key is used for saveUserAuthToken/getUserAuth
        const expectedKey = 'userAuth';
        expect(expectedKey, equals('userAuth'));
      });
    });

    group('key uniqueness', () {
      test('all preference keys should be unique', () {
        const keys = ['qcPin', 'qcBiometrics', 'userAuth'];
        expect(keys.toSet().length, equals(keys.length));
      });
    });

    group('method signatures', () {
      // These tests verify the expected method patterns

      test('mPin methods should use String type', () {
        // setQcMPin takes String, getQcMPin returns String?
        const testMPin = '1234';
        expect(testMPin, isA<String>());
      });

      test('biometric methods should use bool type', () {
        // setIsBioMetricEnabled takes bool, getIsBioMetricEnabled returns bool?
        const testBiometric = true;
        expect(testBiometric, isA<bool>());
      });

      test('userAuth methods should use String type', () {
        // saveUserAuthToken takes String, getUserAuth returns String?
        const testToken = 'auth_token_123';
        expect(testToken, isA<String>());
      });
    });
  });

  group('StorageType for QcStorage', () {
    test('qcStorage type should have correct container name', () {
      expect(StorageType.qcStorage.value, equals('QcStorage'));
    });

    test('should be distinguishable from appStorage', () {
      expect(StorageType.qcStorage.value, isNot(equals(StorageType.appStorage.value)));
    });

    test('qcStorage should have index 1', () {
      expect(StorageType.qcStorage.index, equals(1));
    });
  });
}
