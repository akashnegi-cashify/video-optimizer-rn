import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/screens/warehouse_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/screens/on_going_audit_screen.dart';

void main() {
  group('WarehouseAuditPerformScreen', () {
    test('has correct pageKey', () {
      expect(WarehouseAuditPerformScreen.pageKey, 'QC_warehouse_audit_perform_screen');
    });

    test('has correct route', () {
      expect(WarehouseAuditPerformScreen.route, '/warehouse_audit_perform_screen');
    });

    test('can be instantiated', () {
      const screen = WarehouseAuditPerformScreen();
      expect(screen, isNotNull);
    });

    test('buildView method exists', () {
      const screen = WarehouseAuditPerformScreen();
      expect(screen.buildView, isNotNull);
    });
  });

  group('WarehouseAuditPerformScreenArg', () {
    test('can be instantiated with auditId', () {
      final arg = WarehouseAuditPerformScreenArg(123);
      expect(arg.auditId, 123);
    });

    test('toJson returns correct map', () {
      final arg = WarehouseAuditPerformScreenArg(456);
      final json = arg.toJson();
      expect(json, isA<Map<String, dynamic>>());
      expect(json.containsValue(456), isTrue);
    });
  });

  group('OnGoingAuditScreen', () {
    test('has correct pageKey', () {
      expect(OnGoingAuditScreen.pageKey, 'QC_on_going_audit_screen');
    });

    test('has correct route', () {
      expect(OnGoingAuditScreen.route, '/ongoing_audit_screen');
    });

    test('can be instantiated', () {
      const screen = OnGoingAuditScreen();
      expect(screen, isNotNull);
    });

    test('buildView method exists', () {
      const screen = OnGoingAuditScreen();
      expect(screen.buildView, isNotNull);
    });
  });
}
