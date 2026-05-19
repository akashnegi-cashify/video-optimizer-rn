/// Test data fixtures for unit tests.
///
/// This file contains reusable test data that can be used across
/// multiple test files to ensure consistency.

/// Common test constants
class TestFixtures {
  // Device-related fixtures
  static const String testDeviceBarcode = 'TEST_BARCODE_001';
  static const String testDeviceId = '12345';
  static const String testImei = '123456789012345';

  // Lot-related fixtures
  static const String testLotName = 'TEST_LOT_001';
  static const int testLotId = 100;
  static const String testGroupLotName = 'TEST_GROUP_LOT';

  // User-related fixtures
  static const int testUserId = 1;
  static const String testUserName = 'Test User';
  static const String testSsoToken = 'test_sso_token_123';

  // Login type fixtures
  static const String testLoginTypeQc = 'qc_login';
  static const String testLoginTypeTrc = 'trc_login';
  static const String testLoginTypeRms = 'rms_login';

  // Facility fixtures
  static const int testFacilityId = 1;
  static const String testFacilityName = 'Test Facility';
  static const String testFacilityCity = 'Test City';
  static const String testFacilityCode = 'TF001';

  // Common response fixtures
  static Map<String, dynamic> successResponse() => {
        'status': 'success',
        'code': 200,
      };

  static Map<String, dynamic> errorResponse() => {
        'status': 'error',
        'code': 400,
        'message': 'Test error message',
      };

  // Facility JSON fixtures
  static Map<String, dynamic> facilityJson() => {
        'id': testFacilityId,
        'name': testFacilityName,
        'city': testFacilityCity,
        'fc': testFacilityCode,
      };

  static Map<String, dynamic> facilityJsonWithNulls() => {
        'id': null,
        'name': null,
        'city': null,
        'fc': null,
      };

  // Analytics event fixtures
  static Map<String, dynamic> analyticsEventParams() => {
        'event_name': 'test_event',
        'user_id': testUserId,
        'device_barcode': testDeviceBarcode,
        'timestamp': DateTime.now().toIso8601String(),
      };
}
