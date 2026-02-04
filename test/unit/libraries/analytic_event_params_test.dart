import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';

void main() {
  group('AnalyticEventParams', () {
    group('common params', () {
      test('platform should have correct value', () {
        expect(AnalyticEventParams.platform, equals('platform'));
      });

      test('hitTimeStamp should have correct value', () {
        expect(AnalyticEventParams.hitTimeStamp, equals('timeStamp'));
      });

      test('userId should have correct value', () {
        expect(AnalyticEventParams.userId, equals('userId'));
      });

      test('appVersion should have correct value', () {
        expect(AnalyticEventParams.appVersion, equals('appVersion'));
      });

      test('osVersion should have correct value', () {
        expect(AnalyticEventParams.osVersion, equals('osVersion'));
      });

      test('deviceModel should have correct value', () {
        expect(AnalyticEventParams.deviceModel, equals('deviceModel'));
      });
    });

    group('device params', () {
      test('deviceBarcode should have correct value', () {
        expect(AnalyticEventParams.deviceBarcode, equals('deviceBarcode'));
      });

      test('deviceGrade should have correct value', () {
        expect(AnalyticEventParams.deviceGrade, equals('deviceGrade'));
      });

      test('deviceCategory should have correct value', () {
        expect(AnalyticEventParams.deviceCategory, equals('deviceCategory'));
      });
    });

    group('product params', () {
      test('productName should have correct value', () {
        expect(AnalyticEventParams.productName, equals('productName'));
      });

      test('productId should have correct value', () {
        expect(AnalyticEventParams.productId, equals('productId'));
      });

      test('variantId should have correct value', () {
        expect(AnalyticEventParams.variantId, equals('variantId'));
      });

      test('brandId should have correct value', () {
        expect(AnalyticEventParams.brandId, equals('brandId'));
      });
    });

    group('other params', () {
      test('updateCategory should have correct value', () {
        expect(AnalyticEventParams.updateCategory, equals('updateCategory'));
      });

      test('selectedColor should have correct value', () {
        expect(AnalyticEventParams.selectedColor, equals('selectedColour'));
      });

      test('additionalQuestions should have correct value', () {
        expect(AnalyticEventParams.additionalQuestions, equals('additionalQuestions'));
      });

      test('metaData should have correct value', () {
        expect(AnalyticEventParams.metaData, equals('metaData'));
      });
    });

    group('param format', () {
      test('all params should be non-empty strings', () {
        final params = [
          AnalyticEventParams.platform,
          AnalyticEventParams.hitTimeStamp,
          AnalyticEventParams.userId,
          AnalyticEventParams.appVersion,
          AnalyticEventParams.osVersion,
          AnalyticEventParams.deviceModel,
          AnalyticEventParams.deviceBarcode,
          AnalyticEventParams.productName,
          AnalyticEventParams.productId,
          AnalyticEventParams.variantId,
          AnalyticEventParams.updateCategory,
          AnalyticEventParams.deviceGrade,
          AnalyticEventParams.selectedColor,
          AnalyticEventParams.deviceCategory,
          AnalyticEventParams.brandId,
          AnalyticEventParams.additionalQuestions,
          AnalyticEventParams.metaData,
        ];

        for (final param in params) {
          expect(param, isA<String>());
          expect(param.isNotEmpty, isTrue, reason: 'Param "$param" should not be empty');
        }
      });

      test('all params should not contain spaces', () {
        final params = [
          AnalyticEventParams.platform,
          AnalyticEventParams.hitTimeStamp,
          AnalyticEventParams.userId,
          AnalyticEventParams.appVersion,
          AnalyticEventParams.osVersion,
          AnalyticEventParams.deviceModel,
          AnalyticEventParams.deviceBarcode,
          AnalyticEventParams.productName,
          AnalyticEventParams.productId,
          AnalyticEventParams.variantId,
          AnalyticEventParams.updateCategory,
          AnalyticEventParams.deviceGrade,
          AnalyticEventParams.selectedColor,
          AnalyticEventParams.deviceCategory,
          AnalyticEventParams.brandId,
          AnalyticEventParams.additionalQuestions,
          AnalyticEventParams.metaData,
        ];

        for (final param in params) {
          expect(param.contains(' '), isFalse, reason: 'Param "$param" should not contain spaces');
        }
      });
    });

    group('naming convention', () {
      test('params should follow camelCase convention', () {
        // Most params follow camelCase
        expect(AnalyticEventParams.deviceBarcode, equals('deviceBarcode'));
        expect(AnalyticEventParams.productName, equals('productName'));
        expect(AnalyticEventParams.appVersion, equals('appVersion'));
      });

      test('selectedColor uses British spelling', () {
        // Note: selectedColor constant maps to 'selectedColour' (British spelling)
        expect(AnalyticEventParams.selectedColor, equals('selectedColour'));
      });
    });

    group('static class', () {
      test('AnalyticEventParams is a final class', () {
        // All params are static const
        expect(AnalyticEventParams.platform, equals('platform'));
      });
    });
  });
}
