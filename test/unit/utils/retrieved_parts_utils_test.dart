import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/models/retreived_part_required_list_reponse.dart';
import 'package:flutter_trc/src/modules/engineer/retreived_parts/utils/retrieved_parts_utils.dart';

void main() {
  group('RetrievedPartsUtils', () {
    group('checkForMandatoryFields', () {
      test('should return false when list is null', () {
        // Arrange
        const List<RetrievedPartListResponseData?>? dataList = null;

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when list is empty', () {
        // Arrange
        final List<RetrievedPartListResponseData?> dataList = [];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return true when all items have mandatory fields', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image2.jpg',
            barcode: 'BC002',
            reasonId: 2,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isTrue);
      });

      test('should return false when s3Url is null for any item', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
          ),
          RetrievedPartListResponseData(
            s3Url: null, // Missing s3Url
            barcode: 'BC002',
            reasonId: 2,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when barcode is null for any item', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image2.jpg',
            barcode: null, // Missing barcode
            reasonId: 2,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when reasonId is null for any item', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image2.jpg',
            barcode: 'BC002',
            reasonId: null, // Missing reasonId
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when first item has null s3Url', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: null, // Missing s3Url
            barcode: 'BC001',
            reasonId: 1,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image2.jpg',
            barcode: 'BC002',
            reasonId: 2,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when first item has null barcode', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: null, // Missing barcode
            reasonId: 1,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image2.jpg',
            barcode: 'BC002',
            reasonId: 2,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when first item has null reasonId', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: null, // Missing reasonId
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image2.jpg',
            barcode: 'BC002',
            reasonId: 2,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return true for single item with all mandatory fields', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isTrue);
      });

      test('should return false for single item missing s3Url', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: null,
            barcode: 'BC001',
            reasonId: 1,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false for single item missing barcode', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: null,
            reasonId: 1,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false for single item missing reasonId', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: null,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when all mandatory fields are null for an item', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: null,
            barcode: null,
            reasonId: null,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return true for multiple items all with mandatory fields', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image2.jpg',
            barcode: 'BC002',
            reasonId: 2,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image3.jpg',
            barcode: 'BC003',
            reasonId: 3,
          ),
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image4.jpg',
            barcode: 'BC004',
            reasonId: 4,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isTrue);
      });

      test('should return false when list contains null element', () {
        // Arrange
        final List<RetrievedPartListResponseData?> dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
          ),
          null, // Null element
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should return false when last item in large list has missing field', () {
        // Arrange
        final dataList = List.generate(
          10,
          (index) => RetrievedPartListResponseData(
            s3Url: 'https://example.com/image$index.jpg',
            barcode: 'BC00$index',
            reasonId: index,
          ),
        )..add(
            RetrievedPartListResponseData(
              s3Url: null, // Missing s3Url in last item
              barcode: 'BC010',
              reasonId: 10,
            ),
          );

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isFalse);
      });

      test('should ignore non-mandatory fields when checking', () {
        // Arrange - item has s3Url, barcode, reasonId but missing other optional fields
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
            // These optional fields are null
            categoryCode: null,
            partRequestId: null,
            partRequestName: null,
            remark: null,
            reasonLabel: null,
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isTrue);
      });

      test('should work with items having additional optional fields populated', () {
        // Arrange
        final dataList = [
          RetrievedPartListResponseData(
            s3Url: 'https://example.com/image1.jpg',
            barcode: 'BC001',
            reasonId: 1,
            categoryCode: 'CAT001',
            partRequestId: 100,
            partRequestName: 'Part Request 1',
            remark: 'Some remark',
            reasonLabel: 'Reason 1',
          ),
        ];

        // Act
        final result = RetrievedPartsUtils.checkForMandatoryFields(dataList);

        // Assert
        expect(result, isTrue);
      });
    });
  });
}
