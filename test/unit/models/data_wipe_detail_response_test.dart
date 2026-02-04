import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_detail_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';

/// Tests for DataWipeDetailResponse model.
/// Focus: Testing JsonSerializable fromJson/toJson with nested DataWipeListItem.
void main() {
  group('DataWipeDetailResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly with complete dt object', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'id': 1,
            'qrCode': 'QR001',
            'ep': 'Blancco',
            'sd': 'Completed',
            'sc': 100,
            'pn': 'iPhone 14 Pro',
            'em': null,
            'apiName': 'mobile',
            'imei': '123456789012345',
            'imei2': '543210987654321',
            'sno': 'SN001',
            'epc': 1,
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail, isNotNull);
        expect(response.trackUrl, 'https://example.com/track');
        expect(response.cashifyAlert, null);

        final detail = response.dataWipeDetail!;
        expect(detail.id, 1);
        expect(detail.qrCode, 'QR001');
        expect(detail.erasureProvider, 'Blancco');
        expect(detail.status, 'Completed');
        expect(detail.statusCode, 100);
        expect(detail.productName, 'iPhone 14 Pro');
        expect(detail.errorMessage, null);
        expect(detail.categoryKey, 'mobile');
        expect(detail.imei1, '123456789012345');
        expect(detail.imei2, '543210987654321');
        expect(detail.serialNo, 'SN001');
        expect(detail.erasureProviderKey, 1);
      });

      test('should handle null dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail, null);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should handle dt with partial data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'id': 5,
            'qrCode': 'PARTIAL001',
            'pn': 'Samsung Galaxy S24',
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail, isNotNull);
        expect(response.dataWipeDetail?.id, 5);
        expect(response.dataWipeDetail?.qrCode, 'PARTIAL001');
        expect(response.dataWipeDetail?.productName, 'Samsung Galaxy S24');
        expect(response.dataWipeDetail?.erasureProvider, null);
        expect(response.dataWipeDetail?.status, null);
        expect(response.dataWipeDetail?.statusCode, null);
      });

      test('should handle dt with error message', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'id': 10,
            'qrCode': 'ERROR001',
            'sd': 'Failed',
            'sc': 500,
            'em': 'Device is locked with FMI (Find My iPhone)',
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail?.status, 'Failed');
        expect(response.dataWipeDetail?.statusCode, 500);
        expect(response.dataWipeDetail?.errorMessage,
            'Device is locked with FMI (Find My iPhone)');
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Warning',
            'msg': 'Data wipe operation timed out',
          },
          'turl': null,
          'dt': {
            'id': 1,
            'qrCode': 'QR001',
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.dataWipeDetail, isNotNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = DataWipeDetailResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          'dt': {
            'id': 1,
            'qrCode': 'QR001',
            'ep': 'Blancco',
            'sd': 'Completed',
            'sc': 100,
            'pn': 'iPhone 14',
            'em': null,
            'apiName': 'mobile',
            'imei': '123456789012345',
            'imei2': '543210987654321',
            'sno': 'SN001',
            'epc': 1,
          },
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['turl'], 'https://track.com');
        expect(json['dt'], isNotNull);

        // toJson returns DataWipeListItem object, not Map
        final dtItem = json['dt'] as DataWipeListItem;
        expect(dtItem.id, 1);
        expect(dtItem.qrCode, 'QR001');
        expect(dtItem.erasureProvider, 'Blancco');
        expect(dtItem.status, 'Completed');
        expect(dtItem.statusCode, 100);
        expect(dtItem.productName, 'iPhone 14');
        expect(dtItem.errorMessage, null);
        expect(dtItem.categoryKey, 'mobile');
        expect(dtItem.imei1, '123456789012345');
        expect(dtItem.imei2, '543210987654321');
        expect(dtItem.serialNo, 'SN001');
        expect(dtItem.erasureProviderKey, 1);
      });

      test('should handle null dt in serialization', () {
        // Arrange
        final response = DataWipeDetailResponse(null, null, 'https://track.com');

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['turl'], 'https://track.com');
      });

      test('should handle all null fields in serialization', () {
        // Arrange
        final response = DataWipeDetailResponse(null, null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], null);
        expect(json['__ca'], null);
        expect(json['turl'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {
            'id': 42,
            'qrCode': 'ROUND-TRIP-001',
            'ep': 'TestProvider',
            'sd': 'Success',
            'sc': 200,
            'pn': 'Test Device',
            'em': 'No errors',
            'apiName': 'test',
            'imei': '111222333444555',
            'imei2': '555444333222111',
            'sno': 'SERIAL123',
            'epc': 99,
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['turl'], originalJson['turl']);

        final originalDt = originalJson['dt'] as Map<String, dynamic>;
        // toJson returns DataWipeListItem object, not Map
        final serializedDt = serializedJson['dt'] as DataWipeListItem;

        expect(serializedDt.id, originalDt['id']);
        expect(serializedDt.qrCode, originalDt['qrCode']);
        expect(serializedDt.erasureProvider, originalDt['ep']);
        expect(serializedDt.status, originalDt['sd']);
        expect(serializedDt.statusCode, originalDt['sc']);
        expect(serializedDt.productName, originalDt['pn']);
        expect(serializedDt.errorMessage, originalDt['em']);
        expect(serializedDt.categoryKey, originalDt['apiName']);
        expect(serializedDt.imei1, originalDt['imei']);
        expect(serializedDt.imei2, originalDt['imei2']);
        expect(serializedDt.serialNo, originalDt['sno']);
        expect(serializedDt.erasureProviderKey, originalDt['epc']);
      });

      test('should maintain null dt through round-trip', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['dt'], null);
        expect(serializedJson['turl'], 'https://track.com');
      });
    });

    group('edge cases', () {
      test('should handle dt with special characters', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'id': 1,
            'qrCode': 'QR-with-special_chars.123',
            'pn': 'iPhone 15 Pro Max (256GB) - Blue',
            'em': 'Error: Device locked! Contact support@example.com',
            'sno': 'SN/2024/001-XYZ',
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail?.qrCode, 'QR-with-special_chars.123');
        expect(response.dataWipeDetail?.productName,
            'iPhone 15 Pro Max (256GB) - Blue');
        expect(response.dataWipeDetail?.errorMessage,
            'Error: Device locked! Contact support@example.com');
        expect(response.dataWipeDetail?.serialNo, 'SN/2024/001-XYZ');
      });

      test('should handle dt with unicode characters', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'id': 1,
            'pn': 'Samsung Galaxy S24 日本語 🎉',
            'em': 'エラー: デバイスがロックされています',
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail?.productName,
            'Samsung Galaxy S24 日本語 🎉');
        expect(response.dataWipeDetail?.errorMessage,
            'エラー: デバイスがロックされています');
      });

      test('should handle dt with large numeric values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'id': 2147483647,
            'sc': 999999,
            'epc': 1000000,
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail?.id, 2147483647);
        expect(response.dataWipeDetail?.statusCode, 999999);
        expect(response.dataWipeDetail?.erasureProviderKey, 1000000);
      });

      test('should handle dt with empty strings', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': '',
          'dt': {
            'id': 1,
            'qrCode': '',
            'ep': '',
            'sd': '',
            'pn': '',
            'em': '',
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, '');
        expect(response.dataWipeDetail?.qrCode, '');
        expect(response.dataWipeDetail?.erasureProvider, '');
        expect(response.dataWipeDetail?.status, '');
        expect(response.dataWipeDetail?.productName, '');
        expect(response.dataWipeDetail?.errorMessage, '');
      });

      test('should handle dt with zero values for integers', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'id': 0,
            'sc': 0,
            'epc': 0,
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail?.id, 0);
        expect(response.dataWipeDetail?.statusCode, 0);
        expect(response.dataWipeDetail?.erasureProviderKey, 0);
      });

      test('should handle only trackUrl with null dt', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/tracking/12345',
          'dt': null,
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, 'https://example.com/tracking/12345');
        expect(response.dataWipeDetail, null);
        expect(response.cashifyAlert, null);
      });
    });

    group('dataWipeDetail type', () {
      test('dataWipeDetail should be of type DataWipeListItem', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {
            'id': 1,
            'qrCode': 'QR001',
          },
        };

        // Act
        final response = DataWipeDetailResponse.fromJson(json);

        // Assert
        expect(response.dataWipeDetail, isA<DataWipeListItem>());
      });
    });
  });
}
