import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/resources/pii_service.dart';
import 'package:flutter_trc/src/common/resources/pii_decryption_response.dart';

void main() {
  group('PiiService', () {
    group('getPiiInformation', () {
      test('returns stream of PiiDecryptionResponse', () {
        final stream = PiiService.getPiiInformation('test-pii-key');
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('accepts null pii parameter', () {
        final stream = PiiService.getPiiInformation(null);
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('accepts empty string pii parameter', () {
        final stream = PiiService.getPiiInformation('');
        expect(stream, isA<Stream<PiiDecryptionResponse?>>());
      });

      test('method is callable with valid pii key', () {
        expect(() => PiiService.getPiiInformation('valid-key-123'), returnsNormally);
      });

      test('method is callable with special characters in pii', () {
        expect(
          () => PiiService.getPiiInformation('key=with&special+chars'),
          returnsNormally,
        );
      });
    });
  });
}
