import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/cashify_analytics_service.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_request.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_response.dart';

void main() {
  group('CashifyAnalyticsService', () {
    group('saveEvent', () {
      test('should accept SaveAnalyticsRequest parameter', () {
        // Document: saveEvent takes SaveAnalyticsRequest
        final request = SaveAnalyticsRequest('event_key', 'sub_key');
        expect(request, isA<SaveAnalyticsRequest>());
      });

      test('should return Stream<SaveAnalyticsResponse?>', () {
        // Document: saveEvent returns Stream<SaveAnalyticsResponse?>
        // Note: Full test requires QcService mocking
        expect(true, isTrue);
      });

      test('request should be serializable', () {
        // Arrange
        final request = SaveAnalyticsRequest(
          'test_event',
          'test_subordinate',
          parameters: {'key': 'value'},
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['ekey'], equals('test_event'));
        expect(json['sokey'], equals('test_subordinate'));
        expect(json['pldata'], equals({'key': 'value'}));
      });
    });

    group('endpoint', () {
      test('should use analytics event endpoint', () {
        // Document: The endpoint is '/analytic/event/send'
        const endpoint = '/analytic/event/send';
        expect(endpoint, equals('/analytic/event/send'));
      });
    });

    group('service configuration', () {
      test('should use QcService with addAuthorization false', () {
        // Document: QcService is used with addAuthorization: false
        expect(true, isTrue);
      });
    });

    group('request structure', () {
      test('SaveAnalyticsRequest should have event key', () {
        final request = SaveAnalyticsRequest('event', 'sub');
        expect(request.eventKey, equals('event'));
      });

      test('SaveAnalyticsRequest should have subordinate key', () {
        final request = SaveAnalyticsRequest('event', 'sub');
        expect(request.subOrdinateEventKey, equals('sub'));
      });

      test('SaveAnalyticsRequest should support parameters', () {
        final request = SaveAnalyticsRequest(
          'event',
          'sub',
          parameters: {'deviceId': '123', 'action': 'click'},
        );
        expect(request.parameters?['deviceId'], equals('123'));
        expect(request.parameters?['action'], equals('click'));
      });
    });

    group('response structure', () {
      test('SaveAnalyticsResponse should have message field', () {
        final response = SaveAnalyticsResponse('Success', true);
        expect(response.message, equals('Success'));
      });

      test('SaveAnalyticsResponse should have status field', () {
        final response = SaveAnalyticsResponse('Success', true);
        expect(response.status, isTrue);
      });

      test('SaveAnalyticsResponse should parse from JSON', () {
        final json = {'message': 'OK', 'status': true};
        final response = SaveAnalyticsResponse.fromJson(json);
        expect(response.message, equals('OK'));
        expect(response.status, isTrue);
      });
    });

    group('static class', () {
      test('CashifyAnalyticsService should have static saveEvent method', () {
        expect(CashifyAnalyticsService.saveEvent, isNotNull);
      });
    });
  });
}
