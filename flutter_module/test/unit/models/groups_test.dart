import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

/// Tests for ComponentGroup and PageGroup enums.
/// Focus: Testing enum values and AbsComponentGroup/AbsPageGroup implementation.
void main() {
  group('ComponentGroup', () {
    group('enum values', () {
      test('should have expected number of values', () {
        // ComponentGroup has 84 enum values
        expect(ComponentGroup.values.length, greaterThan(80));
      });

      test('should contain actionComponentKey', () {
        expect(
            ComponentGroup.values, contains(ComponentGroup.actionComponentKey));
      });

      test('should contain loginComponentKey', () {
        expect(
            ComponentGroup.values, contains(ComponentGroup.loginComponentKey));
      });

      test('should contain homeComponentKey', () {
        expect(
            ComponentGroup.values, contains(ComponentGroup.homeComponentKey));
      });

      test('should contain calculatorComponentKey', () {
        expect(ComponentGroup.values,
            contains(ComponentGroup.calculatorComponentKey));
      });

      test('should contain qcGeneralHeaderComponentKey', () {
        expect(ComponentGroup.values,
            contains(ComponentGroup.qcGeneralHeaderComponentKey));
      });
    });

    group('value property', () {
      test('actionComponentKey should have correct value', () {
        expect(ComponentGroup.actionComponentKey.value, 'Action');
      });

      test('loginComponentKey should have correct value', () {
        expect(ComponentGroup.loginComponentKey.value, 'Login');
      });

      test('homeComponentKey should have correct value', () {
        expect(ComponentGroup.homeComponentKey.value, 'Home');
      });

      test('calculatorComponentKey should have correct value', () {
        expect(ComponentGroup.calculatorComponentKey.value, 'Calculator');
      });

      test('deviceReceiveComponentKey should have correct value', () {
        expect(ComponentGroup.deviceReceiveComponentKey.value, 'Device Receive');
      });

      test('StoreIn should have correct value', () {
        expect(ComponentGroup.StoreIn.value, 'Store In');
      });

      test('StoreOut should have correct value', () {
        expect(ComponentGroup.StoreOut.value, 'Store Out');
      });

      test('DeviceDead should have correct value', () {
        expect(ComponentGroup.DeviceDead.value, 'Device Dead');
      });
    });

    group('QC related components', () {
      test('qcActionComponentKey should have correct value', () {
        expect(ComponentGroup.qcActionComponentKey.value, 'QC Action');
      });

      test('qcGeneralHeaderComponentKey should have correct value', () {
        expect(ComponentGroup.qcGeneralHeaderComponentKey.value,
            'QC General Header');
      });

      test('partQcHomeComponentKey should have correct value', () {
        expect(ComponentGroup.partQcHomeComponentKey.value, 'Part Qc Home');
      });
    });

    group('TRC related components', () {
      test('TRCExecutiveComponentKey should have correct value', () {
        expect(ComponentGroup.TRCExecutiveComponentKey.value, 'Trc executive');
      });

      test('trcTesterComponentKey should have correct value', () {
        expect(ComponentGroup.trcTesterComponentKey.value, 'Trc Tester');
      });

      test('trcStoreManagerHomeComponentKey should have correct value', () {
        expect(ComponentGroup.trcStoreManagerHomeComponentKey.value,
            'Store Manager Home Component');
      });
    });

    group('Shipex related components', () {
      test('shipexHomeComponentKey should have correct value', () {
        expect(ComponentGroup.shipexHomeComponentKey.value, 'Shipex Home');
      });

      test('shipexGeneralHeaderComponentKey should have correct value', () {
        expect(ComponentGroup.shipexGeneralHeaderComponentKey.value,
            'Shipex General Header');
      });

      test('shipexPackingComponentKey should have correct value', () {
        expect(ComponentGroup.shipexPackingComponentKey.value, 'Packing');
      });

      test('dispatchComponentKey should have correct value', () {
        expect(ComponentGroup.dispatchComponentKey.value, 'Dispatch');
      });
    });

    group('unique values', () {
      test('all component names should be unique', () {
        final values =
            ComponentGroup.values.map((e) => e.value).toList();
        final uniqueValues = values.toSet();
        expect(uniqueValues.length, values.length);
      });
    });
  });

  group('PageGroup', () {
    group('enum values', () {
      test('should have expected number of values', () {
        // PageGroup has 69 enum values
        expect(PageGroup.values.length, greaterThan(65));
      });

      test('should contain actionPageKey', () {
        expect(PageGroup.values, contains(PageGroup.actionPageKey));
      });

      test('should contain loginPageKey', () {
        expect(PageGroup.values, contains(PageGroup.loginPageKey));
      });

      test('should contain homePageKey', () {
        expect(PageGroup.values, contains(PageGroup.homePageKey));
      });

      test('should contain calculatorPageKey', () {
        expect(PageGroup.values, contains(PageGroup.calculatorPageKey));
      });
    });

    group('value property', () {
      test('actionPageKey should have correct value', () {
        expect(PageGroup.actionPageKey.value, 'Action');
      });

      test('loginPageKey should have correct value', () {
        expect(PageGroup.loginPageKey.value, 'Login');
      });

      test('homePageKey should have correct value', () {
        expect(PageGroup.homePageKey.value, 'Home');
      });

      test('calculatorPageKey should have correct value', () {
        expect(PageGroup.calculatorPageKey.value, 'Calculator');
      });

      test('deviceReceivePageKey should have correct value', () {
        expect(PageGroup.deviceReceivePageKey.value, 'Device Receive');
      });

      test('qcStoreInKey should have correct value', () {
        expect(PageGroup.qcStoreInKey.value, 'Store In');
      });

      test('qcStoreOutKey should have correct value', () {
        expect(PageGroup.qcStoreOutKey.value, 'Store Out');
      });

      test('splashPageKey should have correct value', () {
        expect(PageGroup.splashPageKey.value, 'splash');
      });
    });

    group('QC related pages', () {
      test('qcActionPageKey should have correct value', () {
        expect(PageGroup.qcActionPageKey.value, 'QC Action');
      });

      test('partQcHomePageKey should have correct value', () {
        expect(PageGroup.partQcHomePageKey.value, 'Part Qc Home');
      });

      test('qcDeviceDeadRepairPageKey should have correct value', () {
        expect(PageGroup.qcDeviceDeadRepairPageKey.value, 'Device Dead Repair');
      });

      test('qcReasonSelectionPageKey should have correct value', () {
        expect(PageGroup.qcReasonSelectionPageKey.value, 'Reason Selection');
      });
    });

    group('TRC related pages', () {
      test('trcExecutivePageKey should have correct value', () {
        expect(PageGroup.trcExecutivePageKey.value, 'Trc Executive');
      });

      test('trcTesterPageKey should have correct value', () {
        expect(PageGroup.trcTesterPageKey.value, 'Trc Tester');
      });

      test('trcStoreManagerHomePageKey should have correct value', () {
        expect(PageGroup.trcStoreManagerHomePageKey.value, 'Trc Store Home Manager');
      });
    });

    group('Shipex related pages', () {
      test('shipexHomePageKey should have correct value', () {
        expect(PageGroup.shipexHomePageKey.value, 'Shipex Home');
      });

      test('dispatchPageKey should have correct value', () {
        expect(PageGroup.dispatchPageKey.value, 'Dispatch');
      });

      test('shipexPackingPageKey should have correct value', () {
        expect(PageGroup.shipexPackingPageKey.value, 'Packing');
      });
    });

    group('Audit related pages', () {
      test('auditQuestionPageKey should have correct value', () {
        expect(PageGroup.auditQuestionPageKey.value, 'Audit Question');
      });

      test('auditQuestionSummaryPageKey should have correct value', () {
        expect(PageGroup.auditQuestionSummaryPageKey.value, 'Audit Question Summary');
      });

      test('auditBarcodeScannedPageKey should have correct value', () {
        expect(PageGroup.auditBarcodeScannedPageKey.value, 'Audit Barcode Scanner');
      });
    });

    group('unique values', () {
      test('all page names should be unique', () {
        final values = PageGroup.values.map((e) => e.value).toList();
        final uniqueValues = values.toSet();
        expect(uniqueValues.length, values.length);
      });
    });
  });

  group('ComponentGroup and PageGroup consistency', () {
    test('login component and page should have same display value', () {
      expect(ComponentGroup.loginComponentKey.value, PageGroup.loginPageKey.value);
    });

    test('home component and page should have same display value', () {
      expect(ComponentGroup.homeComponentKey.value, PageGroup.homePageKey.value);
    });

    test('calculator component and page should have same display value', () {
      expect(ComponentGroup.calculatorComponentKey.value, PageGroup.calculatorPageKey.value);
    });

    test('action component and page should have same display value', () {
      expect(ComponentGroup.actionComponentKey.value, PageGroup.actionPageKey.value);
    });
  });
}
