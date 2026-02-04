import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/resources/pre_dispatch_lots_response.dart';

void main() {
  group('PreDispatchLotsResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'data': [
            {
              'lotId': 1001,
              'lotGroupName': 'LOT-GROUP-001',
              'lotCount': 50,
              'scanPending': 30,
              'scanDone': 20,
              'channel': 'B2C',
              'lotType': 'NORMAL',
            },
          ],
          'totalCount': 100,
          'currentPageSize': 10,
          'currentPageNumber': 1,
          'hasNext': true,
        };

        // Act
        final response = PreDispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, isNotNull);
        expect(response.lots!.length, 1);
        expect(response.totalCount, 100);
        expect(response.currentPageSize, 10);
        expect(response.currentPageNumber, 1);
        expect(response.hasNext, true);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = PreDispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, isNull);
        expect(response.totalCount, isNull);
        expect(response.currentPageSize, isNull);
        expect(response.currentPageNumber, isNull);
        expect(response.hasNext, isNull);
      });

      test('should handle empty data array', () {
        // Arrange
        final json = {
          'data': <Map<String, dynamic>>[],
          'totalCount': 0,
          'currentPageSize': 10,
          'currentPageNumber': 1,
          'hasNext': false,
        };

        // Act
        final response = PreDispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, isEmpty);
        expect(response.totalCount, 0);
        expect(response.hasNext, false);
      });

      test('should parse multiple lots', () {
        // Arrange
        final json = {
          'data': [
            {'lotId': 1, 'lotGroupName': 'LOT-1'},
            {'lotId': 2, 'lotGroupName': 'LOT-2'},
            {'lotId': 3, 'lotGroupName': 'LOT-3'},
          ],
          'totalCount': 3,
        };

        // Act
        final response = PreDispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots!.length, 3);
        expect(response.lots![0]?.lotId, 1);
        expect(response.lots![1]?.lotId, 2);
        expect(response.lots![2]?.lotId, 3);
      });

      test('should handle hasNext as false on last page', () {
        // Arrange
        final json = {
          'data': [
            {'lotId': 1},
          ],
          'totalCount': 1,
          'currentPageSize': 10,
          'currentPageNumber': 1,
          'hasNext': false,
        };

        // Act
        final response = PreDispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.hasNext, false);
        expect(response.currentPageNumber, 1);
      });

      test('should handle partial pagination data', () {
        // Arrange
        final json = {
          'data': [],
          'totalCount': 0,
        };

        // Act
        final response = PreDispatchLotsResponse.fromJson(json);

        // Assert
        expect(response.lots, isEmpty);
        expect(response.totalCount, 0);
        expect(response.currentPageSize, isNull);
        expect(response.currentPageNumber, isNull);
        expect(response.hasNext, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final lotInfo = PreDispatchLotInfo(
          lotId: 100,
          lotGroupName: 'TEST-LOT',
          lotCount: 25,
          scanPending: 15,
          scanDone: 10,
          channel: 'B2B',
          lotType: 'PRIORITY',
        );
        final response = PreDispatchLotsResponse(
          lots: [lotInfo],
          totalCount: 1,
          currentPageSize: 10,
          currentPageNumber: 1,
          hasNext: false,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isA<List>());
        expect((json['data'] as List).length, 1);
        expect(json['totalCount'], 1);
        expect(json['currentPageSize'], 10);
        expect(json['currentPageNumber'], 1);
        expect(json['hasNext'], false);
      });

      test('should serialize null values correctly', () {
        // Arrange
        final response = PreDispatchLotsResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isNull);
        expect(json['totalCount'], isNull);
        expect(json['currentPageSize'], isNull);
        expect(json['currentPageNumber'], isNull);
        expect(json['hasNext'], isNull);
      });

      test('should serialize empty lots list', () {
        // Arrange
        final response = PreDispatchLotsResponse(lots: []);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['data'], isEmpty);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final response = PreDispatchLotsResponse(
          lots: [],
          totalCount: 100,
          currentPageSize: 20,
          currentPageNumber: 2,
          hasNext: true,
        );

        // Assert
        expect(response.lots, isEmpty);
        expect(response.totalCount, 100);
        expect(response.currentPageSize, 20);
        expect(response.currentPageNumber, 2);
        expect(response.hasNext, true);
      });

      test('should create instance with no parameters', () {
        // Act
        final response = PreDispatchLotsResponse();

        // Assert
        expect(response.lots, isNull);
        expect(response.totalCount, isNull);
        expect(response.currentPageSize, isNull);
        expect(response.currentPageNumber, isNull);
        expect(response.hasNext, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'data': [
            {
              'lotId': 500,
              'lotGroupName': 'ROUNDTRIP-LOT',
              'lotCount': 30,
              'scanPending': 10,
              'scanDone': 20,
              'channel': 'B2C',
              'lotType': 'EXPRESS',
            },
          ],
          'totalCount': 50,
          'currentPageSize': 15,
          'currentPageNumber': 3,
          'hasNext': true,
        };

        // Act
        final response = PreDispatchLotsResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['totalCount'], originalJson['totalCount']);
        expect(serializedJson['currentPageSize'], originalJson['currentPageSize']);
        expect(serializedJson['currentPageNumber'], originalJson['currentPageNumber']);
        expect(serializedJson['hasNext'], originalJson['hasNext']);
      });
    });
  });

  group('PreDispatchLotInfo', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotId': 2001,
          'lotGroupName': 'PRE-DISPATCH-LOT-001',
          'lotCount': 100,
          'scanPending': 40,
          'scanDone': 60,
          'channel': 'B2C',
          'lotType': 'NORMAL',
        };

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(json);

        // Assert
        expect(lotInfo.lotId, 2001);
        expect(lotInfo.lotGroupName, 'PRE-DISPATCH-LOT-001');
        expect(lotInfo.lotCount, 100);
        expect(lotInfo.scanPending, 40);
        expect(lotInfo.scanDone, 60);
        expect(lotInfo.channel, 'B2C');
        expect(lotInfo.lotType, 'NORMAL');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(json);

        // Assert
        expect(lotInfo.lotId, isNull);
        expect(lotInfo.lotGroupName, isNull);
        expect(lotInfo.lotCount, isNull);
        expect(lotInfo.scanPending, isNull);
        expect(lotInfo.scanDone, isNull);
        expect(lotInfo.channel, isNull);
        expect(lotInfo.lotType, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'lotId': 999,
          'lotGroupName': 'PARTIAL-LOT',
          'lotCount': 50,
        };

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(json);

        // Assert
        expect(lotInfo.lotId, 999);
        expect(lotInfo.lotGroupName, 'PARTIAL-LOT');
        expect(lotInfo.lotCount, 50);
        expect(lotInfo.scanPending, isNull);
        expect(lotInfo.scanDone, isNull);
        expect(lotInfo.channel, isNull);
        expect(lotInfo.lotType, isNull);
      });

      test('should handle zero values', () {
        // Arrange
        final json = {
          'lotId': 0,
          'lotCount': 0,
          'scanPending': 0,
          'scanDone': 0,
        };

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(json);

        // Assert
        expect(lotInfo.lotId, 0);
        expect(lotInfo.lotCount, 0);
        expect(lotInfo.scanPending, 0);
        expect(lotInfo.scanDone, 0);
      });

      test('should handle different channel types', () {
        // Arrange
        final jsonB2C = {'channel': 'B2C'};
        final jsonB2B = {'channel': 'B2B'};
        final jsonRetail = {'channel': 'RETAIL'};

        // Act
        final lotB2C = PreDispatchLotInfo.fromJson(jsonB2C);
        final lotB2B = PreDispatchLotInfo.fromJson(jsonB2B);
        final lotRetail = PreDispatchLotInfo.fromJson(jsonRetail);

        // Assert
        expect(lotB2C.channel, 'B2C');
        expect(lotB2B.channel, 'B2B');
        expect(lotRetail.channel, 'RETAIL');
      });

      test('should handle different lot types', () {
        // Arrange
        final jsonNormal = {'lotType': 'NORMAL'};
        final jsonPriority = {'lotType': 'PRIORITY'};
        final jsonExpress = {'lotType': 'EXPRESS'};

        // Act
        final lotNormal = PreDispatchLotInfo.fromJson(jsonNormal);
        final lotPriority = PreDispatchLotInfo.fromJson(jsonPriority);
        final lotExpress = PreDispatchLotInfo.fromJson(jsonExpress);

        // Assert
        expect(lotNormal.lotType, 'NORMAL');
        expect(lotPriority.lotType, 'PRIORITY');
        expect(lotExpress.lotType, 'EXPRESS');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final lotInfo = PreDispatchLotInfo(
          lotId: 3001,
          lotGroupName: 'SERIALIZE-LOT',
          lotCount: 75,
          scanPending: 25,
          scanDone: 50,
          channel: 'B2B',
          lotType: 'PRIORITY',
        );

        // Act
        final json = lotInfo.toJson();

        // Assert
        expect(json['lotId'], 3001);
        expect(json['lotGroupName'], 'SERIALIZE-LOT');
        expect(json['lotCount'], 75);
        expect(json['scanPending'], 25);
        expect(json['scanDone'], 50);
        expect(json['channel'], 'B2B');
        expect(json['lotType'], 'PRIORITY');
      });

      test('should serialize null values correctly', () {
        // Arrange
        final lotInfo = PreDispatchLotInfo();

        // Act
        final json = lotInfo.toJson();

        // Assert
        expect(json['lotId'], isNull);
        expect(json['lotGroupName'], isNull);
        expect(json['lotCount'], isNull);
        expect(json['scanPending'], isNull);
        expect(json['scanDone'], isNull);
        expect(json['channel'], isNull);
        expect(json['lotType'], isNull);
      });

      test('should serialize partial values correctly', () {
        // Arrange
        final lotInfo = PreDispatchLotInfo(
          lotId: 123,
          lotGroupName: 'PARTIAL-SERIALIZE',
        );

        // Act
        final json = lotInfo.toJson();

        // Assert
        expect(json['lotId'], 123);
        expect(json['lotGroupName'], 'PARTIAL-SERIALIZE');
        expect(json['lotCount'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final lotInfo = PreDispatchLotInfo(
          lotId: 4001,
          lotGroupName: 'CONSTRUCTOR-LOT',
          lotCount: 200,
          scanPending: 80,
          scanDone: 120,
          channel: 'B2C',
          lotType: 'NORMAL',
        );

        // Assert
        expect(lotInfo.lotId, 4001);
        expect(lotInfo.lotGroupName, 'CONSTRUCTOR-LOT');
        expect(lotInfo.lotCount, 200);
        expect(lotInfo.scanPending, 80);
        expect(lotInfo.scanDone, 120);
        expect(lotInfo.channel, 'B2C');
        expect(lotInfo.lotType, 'NORMAL');
      });

      test('should create instance with no parameters', () {
        // Act
        final lotInfo = PreDispatchLotInfo();

        // Assert
        expect(lotInfo.lotId, isNull);
        expect(lotInfo.lotGroupName, isNull);
        expect(lotInfo.lotCount, isNull);
        expect(lotInfo.scanPending, isNull);
        expect(lotInfo.scanDone, isNull);
        expect(lotInfo.channel, isNull);
        expect(lotInfo.lotType, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'lotId': 5001,
          'lotGroupName': 'ROUNDTRIP-LOT-INFO',
          'lotCount': 150,
          'scanPending': 50,
          'scanDone': 100,
          'channel': 'B2C',
          'lotType': 'EXPRESS',
        };

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(originalJson);
        final serializedJson = lotInfo.toJson();

        // Assert
        expect(serializedJson['lotId'], originalJson['lotId']);
        expect(serializedJson['lotGroupName'], originalJson['lotGroupName']);
        expect(serializedJson['lotCount'], originalJson['lotCount']);
        expect(serializedJson['scanPending'], originalJson['scanPending']);
        expect(serializedJson['scanDone'], originalJson['scanDone']);
        expect(serializedJson['channel'], originalJson['channel']);
        expect(serializedJson['lotType'], originalJson['lotType']);
      });
    });

    group('edge cases', () {
      test('should handle large lot count', () {
        // Arrange
        final json = {
          'lotCount': 999999,
          'scanPending': 500000,
          'scanDone': 499999,
        };

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(json);

        // Assert
        expect(lotInfo.lotCount, 999999);
        expect(lotInfo.scanPending, 500000);
        expect(lotInfo.scanDone, 499999);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'lotGroupName': '',
          'channel': '',
          'lotType': '',
        };

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(json);

        // Assert
        expect(lotInfo.lotGroupName, '');
        expect(lotInfo.channel, '');
        expect(lotInfo.lotType, '');
      });

      test('should handle scan counts equal to lot count', () {
        // Arrange
        final json = {
          'lotCount': 100,
          'scanPending': 0,
          'scanDone': 100,
        };

        // Act
        final lotInfo = PreDispatchLotInfo.fromJson(json);

        // Assert
        expect(lotInfo.lotCount, 100);
        expect(lotInfo.scanPending, 0);
        expect(lotInfo.scanDone, 100);
      });
    });
  });
}
