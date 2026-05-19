import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/imei_validator/screens/imei_validator_screen.dart';
import 'package:flutter_trc/qc/modules/imei_validator/resources/imei_qrcode_response.dart';

void main() {
  group('ImeiValidatorScreen', () {
    test('has correct pageKey', () {
      expect(ImeiValidatorScreen.pageKey, 'QC_IMEI_Validator_page_key');
    });

    test('has correct route', () {
      expect(ImeiValidatorScreen.route, '/qc_imei_validator');
    });

    test('can be instantiated', () {
      const screen = ImeiValidatorScreen();
      expect(screen, isNotNull);
    });

    test('buildView method exists', () {
      const screen = ImeiValidatorScreen();
      expect(screen.buildView, isNotNull);
    });
  });

  group('ImeiValidatorScreenArg', () {
    test('can be instantiated with null response', () {
      final arg = ImeiValidatorScreenArg(null);
      expect(arg.imeiQrcodeResponse, isNull);
    });

    test('can be instantiated with ImeiQrcodeResponse', () {
      final response = ImeiQrcodeResponse();
      final arg = ImeiValidatorScreenArg(response);
      expect(arg.imeiQrcodeResponse, response);
    });

    test('toMap returns a Map', () {
      final arg = ImeiValidatorScreenArg(null);
      final map = arg.toMap();
      expect(map, isA<Map<String, dynamic>>());
    });

    test('toMap contains qrcodeResponse key', () {
      final response = ImeiQrcodeResponse();
      final arg = ImeiValidatorScreenArg(response);
      final map = arg.toMap();
      expect(map, isNotNull);
      expect(map!.containsValue(response), isTrue);
    });
  });
}
