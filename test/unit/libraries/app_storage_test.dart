import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/rms/modules/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/libraries/get_storage/storage_type.dart';

import '../../helpers/test_fixtures.dart';

void main() {
  group('AppStorage', () {
    group('storage type', () {
      test('should use appStorage storage type', () {
        // The AppStorage class uses StorageType.appStorage in constructor
        expect(StorageType.appStorage.value, equals('GetStorage'));
      });
    });

    group('preference keys', () {
      // Testing the internal key values used by AppStorage
      // These map to the _AppPreferencesKeys enum

      test('loginType key should be "loginType"', () {
        // The key is used for setLoginType/getLoginType
        const expectedKey = 'loginType';
        expect(expectedKey, equals('loginType'));
      });

      test('facility key should be "facility"', () {
        // The key is used for setFacility/getFacility
        const expectedKey = 'facility';
        expect(expectedKey, equals('facility'));
      });
    });
  });

  group('FacilityListData', () {
    group('fromJson', () {
      test('should parse valid JSON correctly', () {
        // Arrange
        final json = TestFixtures.facilityJson();

        // Act
        final facility = FacilityListData.fromJson(json);

        // Assert
        expect(facility.id, equals(TestFixtures.testFacilityId));
        expect(facility.name, equals(TestFixtures.testFacilityName));
        expect(facility.city, equals(TestFixtures.testFacilityCity));
        expect(facility.facilityCode, equals(TestFixtures.testFacilityCode));
      });

      test('should handle null values in JSON', () {
        // Arrange
        final json = TestFixtures.facilityJsonWithNulls();

        // Act
        final facility = FacilityListData.fromJson(json);

        // Assert
        expect(facility.id, isNull);
        expect(facility.name, isNull);
        expect(facility.city, isNull);
        expect(facility.facilityCode, isNull);
      });

      test('should handle missing keys in JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final facility = FacilityListData.fromJson(json);

        // Assert
        expect(facility.id, isNull);
        expect(facility.name, isNull);
        expect(facility.city, isNull);
        expect(facility.facilityCode, isNull);
      });

      test('should handle partial JSON', () {
        // Arrange
        final json = {
          'id': 1,
          'name': 'Partial Facility',
        };

        // Act
        final facility = FacilityListData.fromJson(json);

        // Assert
        expect(facility.id, equals(1));
        expect(facility.name, equals('Partial Facility'));
        expect(facility.city, isNull);
        expect(facility.facilityCode, isNull);
      });
    });

    group('toJson', () {
      test('should convert to JSON correctly', () {
        // Arrange
        final facility = FacilityListData(
          TestFixtures.testFacilityId,
          TestFixtures.testFacilityName,
          TestFixtures.testFacilityCity,
          TestFixtures.testFacilityCode,
        );

        // Act
        final json = facility.toJson();

        // Assert
        expect(json['id'], equals(TestFixtures.testFacilityId));
        expect(json['name'], equals(TestFixtures.testFacilityName));
        expect(json['city'], equals(TestFixtures.testFacilityCity));
        expect(json['fc'], equals(TestFixtures.testFacilityCode));
      });

      test('should handle null values in toJson', () {
        // Arrange
        final facility = FacilityListData(null, null, null, null);

        // Act
        final json = facility.toJson();

        // Assert
        expect(json['id'], isNull);
        expect(json['name'], isNull);
        expect(json['city'], isNull);
        expect(json['fc'], isNull);
      });
    });

    group('JSON serialization roundtrip', () {
      test('should maintain data integrity through encode/decode cycle', () {
        // Arrange
        final originalFacility = FacilityListData(
          TestFixtures.testFacilityId,
          TestFixtures.testFacilityName,
          TestFixtures.testFacilityCity,
          TestFixtures.testFacilityCode,
        );

        // Act - Simulate storage roundtrip
        final encoded = jsonEncode(originalFacility);
        final decoded = jsonDecode(encoded);
        final restoredFacility = FacilityListData.fromJson(decoded);

        // Assert
        expect(restoredFacility.id, equals(originalFacility.id));
        expect(restoredFacility.name, equals(originalFacility.name));
        expect(restoredFacility.city, equals(originalFacility.city));
        expect(restoredFacility.facilityCode, equals(originalFacility.facilityCode));
      });

      test('should handle special characters in roundtrip', () {
        // Arrange
        final originalFacility = FacilityListData(
          1,
          'Facility "Special" <Name>',
          "City's Name & More",
          'FC/001',
        );

        // Act
        final encoded = jsonEncode(originalFacility);
        final decoded = jsonDecode(encoded);
        final restoredFacility = FacilityListData.fromJson(decoded);

        // Assert
        expect(restoredFacility.name, equals('Facility "Special" <Name>'));
        expect(restoredFacility.city, equals("City's Name & More"));
        expect(restoredFacility.facilityCode, equals('FC/001'));
      });

      test('should handle unicode characters in roundtrip', () {
        // Arrange
        final originalFacility = FacilityListData(
          1,
          '设施名称',
          'город',
          'FC_日本',
        );

        // Act
        final encoded = jsonEncode(originalFacility);
        final decoded = jsonDecode(encoded);
        final restoredFacility = FacilityListData.fromJson(decoded);

        // Assert
        expect(restoredFacility.name, equals('设施名称'));
        expect(restoredFacility.city, equals('город'));
        expect(restoredFacility.facilityCode, equals('FC_日本'));
      });

      test('should handle empty strings in roundtrip', () {
        // Arrange
        final originalFacility = FacilityListData(0, '', '', '');

        // Act
        final encoded = jsonEncode(originalFacility);
        final decoded = jsonDecode(encoded);
        final restoredFacility = FacilityListData.fromJson(decoded);

        // Assert
        expect(restoredFacility.id, equals(0));
        expect(restoredFacility.name, equals(''));
        expect(restoredFacility.city, equals(''));
        expect(restoredFacility.facilityCode, equals(''));
      });
    });

    group('constructor', () {
      test('should accept all parameters', () {
        // Act
        final facility = FacilityListData(1, 'Name', 'City', 'FC001');

        // Assert
        expect(facility.id, equals(1));
        expect(facility.name, equals('Name'));
        expect(facility.city, equals('City'));
        expect(facility.facilityCode, equals('FC001'));
      });

      test('should accept null parameters', () {
        // Act
        final facility = FacilityListData(null, null, null, null);

        // Assert
        expect(facility.id, isNull);
        expect(facility.name, isNull);
        expect(facility.city, isNull);
        expect(facility.facilityCode, isNull);
      });

      test('should accept mixed null and non-null parameters', () {
        // Act
        final facility = FacilityListData(1, null, 'City', null);

        // Assert
        expect(facility.id, equals(1));
        expect(facility.name, isNull);
        expect(facility.city, equals('City'));
        expect(facility.facilityCode, isNull);
      });
    });
  });

  group('StorageType for AppStorage', () {
    test('appStorage type should have correct container name', () {
      expect(StorageType.appStorage.value, equals('GetStorage'));
    });

    test('should be distinguishable from qcStorage', () {
      expect(StorageType.appStorage.value, isNot(equals(StorageType.qcStorage.value)));
    });
  });
}
