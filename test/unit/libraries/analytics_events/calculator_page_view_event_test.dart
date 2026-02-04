import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/calculator_page_view_event.dart';

void main() {
  group('CalculatorPageViewEvent', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange
        const deviceBarcode = 'DEVICE123';
        const pageNo = 1;
        final questionAnswerIds = {'q1': [1, 2], 'q2': [3]};

        // Act
        final event = CalculatorPageViewEvent(deviceBarcode, pageNo, questionAnswerIds);

        // Assert
        expect(event.deviceBarcode, equals('DEVICE123'));
        expect(event.pageNo, equals(1));
        expect(event.questionAnswerIds, equals(questionAnswerIds));
      });

      test('should create instance with empty question answer ids', () {
        // Arrange & Act
        final event = CalculatorPageViewEvent('DEVICE123', 1, {});

        // Assert
        expect(event.questionAnswerIds, isEmpty);
      });

      test('should create instance with page number 0', () {
        // Arrange & Act
        final event = CalculatorPageViewEvent('DEVICE123', 0, {});

        // Assert
        expect(event.pageNo, equals(0));
      });

      test('should create instance with large page number', () {
        // Arrange & Act
        final event = CalculatorPageViewEvent('DEVICE123', 100, {});

        // Assert
        expect(event.pageNo, equals(100));
      });
    });

    group('getSubordinateKey', () {
      test('should return correct event key format for page 1', () {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE123', 1, {});

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals('${AnalyticEventKeys.manualTesting.calWithPageNo}1_view'));
        expect(key, equals('dmt_cal_p1_view'));
      });

      test('should return correct event key format for page 0', () {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE123', 0, {});

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals('dmt_cal_p0_view'));
      });

      test('should return correct event key format for page 10', () {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE123', 10, {});

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals('dmt_cal_p10_view'));
      });

      test('should include page number in key', () {
        // Arrange
        final event1 = CalculatorPageViewEvent('DEVICE', 1, {});
        final event2 = CalculatorPageViewEvent('DEVICE', 2, {});
        final event3 = CalculatorPageViewEvent('DEVICE', 5, {});

        // Act & Assert
        expect(event1.getSubordinateKey(), contains('1'));
        expect(event2.getSubordinateKey(), contains('2'));
        expect(event3.getSubordinateKey(), contains('5'));
      });

      test('should end with _view suffix', () {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE', 1, {});

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, endsWith('_view'));
      });
    });

    group('getArguments', () {
      test('should include metaData in arguments', () async {
        // Arrange
        final questionAnswerIds = {'q1': [1, 2], 'q2': [3]};
        final event = CalculatorPageViewEvent('DEVICE123', 1, questionAnswerIds);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.metaData], equals(questionAnswerIds));
      });

      test('should include deviceBarcode in arguments', () async {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE123', 1, {});

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should handle empty question answer ids in arguments', () async {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE123', 1, {});

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.metaData], isEmpty);
      });

      test('should handle complex question answer ids', () async {
        // Arrange
        final complexAnswers = {
          'question_1': [1, 2, 3],
          'question_2': [4, 5],
          'question_3': [6],
        };
        final event = CalculatorPageViewEvent('DEVICE456', 2, complexAnswers);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.metaData], equals(complexAnswers));
      });
    });

    group('inheritance from CommonEvents', () {
      test('should include common event arguments', () async {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE', 1, {});

        // Act
        final arguments = await event.getArguments();

        // Assert - Common arguments from CommonEvents
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });

      test('should have getEventKey method', () {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE', 1, {});

        // Assert
        expect(event.getEventKey, isNotNull);
      });

      test('should have getTrackers method', () {
        // Arrange
        final event = CalculatorPageViewEvent('DEVICE', 1, {});

        // Assert
        expect(event.getTrackers, isNotNull);
      });
    });
  });
}
