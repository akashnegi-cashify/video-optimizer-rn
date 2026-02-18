import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';

/// Tests for MyQuoteRequestData model.
/// Focus: Testing the `toJson()` method with conditional field inclusion.
void main() {
  group('MyQuoteRequestData', () {
    group('toJson method', () {
      test('should include color field', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.selectedDeviceColor = 'Red';

        // Act
        final json = request.toJson();

        // Assert
        expect(json['color'], 'Red');
      });

      test('should include sc (strap color) field', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.selectedStrapColor = 'Black';

        // Act
        final json = request.toJson();

        // Assert
        expect(json['sc'], 'Black');
      });

      test('should include rm (remarks) field', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.testingRemarks = 'Minor scratches on back';

        // Act
        final json = request.toJson();

        // Assert
        expect(json['rm'], 'Minor scratches on back');
      });

      test('should include vid (variant id) field', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.variantId = 128;

        // Act
        final json = request.toJson();

        // Assert
        expect(json['vid'], 128);
      });

      test('should include vn (variant name) field', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.variantName = '128GB';

        // Act
        final json = request.toJson();

        // Assert
        expect(json['vn'], '128GB');
      });

      test('should include manualAuditQuestion only when not null', () {
        // Arrange
        final requestWithQuestions = MyQuoteRequestData();
        requestWithQuestions.manualAuditQuestion = [1, 2, 3];

        final requestWithoutQuestions = MyQuoteRequestData();
        requestWithoutQuestions.manualAuditQuestion = null;

        // Act
        final jsonWithQuestions = requestWithQuestions.toJson();
        final jsonWithoutQuestions = requestWithoutQuestions.toJson();

        // Assert
        expect(jsonWithQuestions['mmaids'], [1, 2, 3]);
        expect(jsonWithoutQuestions.containsKey('mmaids'), false);
      });

      test('should include categoryId only when not null', () {
        // Arrange
        final requestWithCategory = MyQuoteRequestData();
        requestWithCategory.categoryId = 5;

        final requestWithoutCategory = MyQuoteRequestData();
        requestWithoutCategory.categoryId = null;

        // Act
        final jsonWithCategory = requestWithCategory.toJson();
        final jsonWithoutCategory = requestWithoutCategory.toJson();

        // Assert
        expect(jsonWithCategory['cat_id'], 5);
        expect(jsonWithoutCategory.containsKey('cat_id'), false);
      });

      test('should include all fields when all are set', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.manualAuditQuestion = [1, 2];
        request.selectedDeviceColor = 'Blue';
        request.selectedStrapColor = 'White';
        request.categoryId = 10;
        request.testingRemarks = 'Good condition';
        request.variantId = 256;
        request.variantName = '256GB';

        // Act
        final json = request.toJson();

        // Assert
        expect(json['mmaids'], [1, 2]);
        expect(json['color'], 'Blue');
        expect(json['sc'], 'White');
        expect(json['cat_id'], 10);
        expect(json['rm'], 'Good condition');
        expect(json['vid'], 256);
        expect(json['vn'], '256GB');
      });

      test('should include null values for non-conditional fields', () {
        // Arrange
        final request = MyQuoteRequestData();
        // All fields left as null

        // Act
        final json = request.toJson();

        // Assert
        // Non-conditional fields should be present even if null
        expect(json.containsKey('color'), true);
        expect(json.containsKey('sc'), true);
        expect(json.containsKey('rm'), true);
        expect(json.containsKey('vid'), true);
        expect(json.containsKey('vn'), true);
        // Conditional fields should not be present when null
        expect(json.containsKey('mmaids'), false);
        expect(json.containsKey('cat_id'), false);
      });

      test('should handle empty manualAuditQuestion list', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.manualAuditQuestion = [];

        // Act
        final json = request.toJson();

        // Assert
        expect(json['mmaids'], []);
      });

      test('should handle manualAuditQuestion with single item', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.manualAuditQuestion = [42];

        // Act
        final json = request.toJson();

        // Assert
        expect(json['mmaids'], [42]);
      });

      test('should handle manualAuditQuestion with multiple items', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.manualAuditQuestion = [1, 5, 10, 15, 20];

        // Act
        final json = request.toJson();

        // Assert
        expect(json['mmaids'], [1, 5, 10, 15, 20]);
        expect((json['mmaids'] as List).length, 5);
      });

      test('should handle empty string values', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.selectedDeviceColor = '';
        request.selectedStrapColor = '';
        request.testingRemarks = '';
        request.variantName = '';

        // Act
        final json = request.toJson();

        // Assert
        expect(json['color'], '');
        expect(json['sc'], '');
        expect(json['rm'], '');
        expect(json['vn'], '');
      });

      test('should handle zero values for variantId and categoryId', () {
        // Arrange
        final request = MyQuoteRequestData();
        request.variantId = 0;
        request.categoryId = 0;

        // Act
        final json = request.toJson();

        // Assert
        expect(json['vid'], 0);
        expect(json['cat_id'], 0);
      });
    });

    group('constructor', () {
      test('should create empty request', () {
        // Arrange & Act
        final request = MyQuoteRequestData();

        // Assert
        expect(request.manualAuditQuestion, null);
        expect(request.selectedDeviceColor, null);
        expect(request.selectedStrapColor, null);
        expect(request.categoryId, null);
        expect(request.testingRemarks, null);
        expect(request.variantId, null);
        expect(request.variantName, null);
      });

      test('should create request with manualAuditQuestion', () {
        // Arrange & Act
        final request = MyQuoteRequestData(manualAuditQuestion: [1, 2, 3]);

        // Assert
        expect(request.manualAuditQuestion, [1, 2, 3]);
      });
    });
  });
}
