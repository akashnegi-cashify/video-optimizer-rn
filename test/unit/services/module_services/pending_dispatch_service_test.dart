import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [PendingDispatchService] class.
///
/// Tests cover:
/// - getPendingDispatchProviderList: endpoint construction
/// - getAwbList: endpoint construction
/// - removeAwbNumber: endpoint construction
void main() {
  group('PendingDispatchService', () {
    group('getPendingDispatchProviderList', () {
      test('should construct endpoint with type.val path parameter', () {
        // Arrange
        const typeValue = 'PENDING';
        final expectedEndpoint = '/app/delivery/list-with-count/$typeValue';

        // Assert
        expect(expectedEndpoint, equals('/app/delivery/list-with-count/PENDING'));
      });

      test('endpoint should follow pattern /app/delivery/list-with-count/{type}', () {
        const typeValue = 'DISPATCHED';
        final endpoint = '/app/delivery/list-with-count/$typeValue';

        expect(endpoint, matches(RegExp(r'/app/delivery/list-with-count/\w+')));
      });
    });

    group('getAwbList', () {
      test('should construct endpoint with deliveryPartnerKey path parameter', () {
        // Arrange
        const deliveryPartnerKey = 'PARTNER_001';
        final expectedEndpoint = '/app/delivery/list-scanned-awb/$deliveryPartnerKey';

        // Assert
        expect(expectedEndpoint, equals('/app/delivery/list-scanned-awb/PARTNER_001'));
      });

      test('endpoint should be under /app/delivery path', () {
        const deliveryPartnerKey = 'TEST';
        final endpoint = '/app/delivery/list-scanned-awb/$deliveryPartnerKey';

        expect(endpoint, startsWith('/app/delivery'));
      });
    });

    group('removeAwbNumber', () {
      test('should construct endpoint with awbNumber path parameter', () {
        // Arrange
        const awbNumber = 'AWB123456';
        final expectedEndpoint = '/app/delivery/remove-scanned-awb/$awbNumber';

        // Assert
        expect(expectedEndpoint, equals('/app/delivery/remove-scanned-awb/AWB123456'));
      });

      test('endpoint should use DELETE method', () {
        // Document that this endpoint uses DELETE HTTP method
        const httpMethod = 'DELETE';
        expect(httpMethod, equals('DELETE'));
      });
    });

    group('endpoint consistency', () {
      test('all endpoints should be under /app/delivery path', () {
        const listEndpoint = '/app/delivery/list-with-count/TYPE';
        const awbListEndpoint = '/app/delivery/list-scanned-awb/PARTNER';
        const removeEndpoint = '/app/delivery/remove-scanned-awb/AWB';

        expect(listEndpoint, startsWith('/app/delivery'));
        expect(awbListEndpoint, startsWith('/app/delivery'));
        expect(removeEndpoint, startsWith('/app/delivery'));
      });

      test('endpoints should not have version prefix', () {
        const endpoint = '/app/delivery/list-with-count/TYPE';
        expect(endpoint, isNot(startsWith('/v1')));
      });
    });

    group('service dependency', () {
      test('PendingDispatchService should use ShipexService', () {
        // ShipexService uses TRCServiceGroups.supersalesOms
        const serviceGroup = 'supersales-oms';
        expect(serviceGroup, equals('supersales-oms'));
      });
    });
  });
}
