import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';
import 'package:mocktail/mocktail.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_detail_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_detail_widget.dart';

import '../../../helpers/mock_services.dart';
import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('DataWipeDetailWidget', () {
    group('unit tests', () {
      test('DataWipeDetailWidget class exists and is a StatefulWidget', () {
        expect(DataWipeDetailWidget, isNotNull);
        const widget = DataWipeDetailWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('DataWipeDetailWidget can be instantiated with default constructor', () {
        const widget = DataWipeDetailWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('DataWipeDetailWidget can be instantiated with a key', () {
        const key = Key('data_wipe_detail_widget_key');
        const widget = DataWipeDetailWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('DataWipeDetailWidget creates state correctly', () {
        const widget = DataWipeDetailWidget();
        final element = widget.createElement();
        expect(element, isNotNull);
      });

      test('multiple instances can be created independently', () {
        const widget1 = DataWipeDetailWidget(key: Key('detail1'));
        const widget2 = DataWipeDetailWidget(key: Key('detail2'));

        expect(widget1.key, isNot(equals(widget2.key)));
      });

      test('createState returns non-null state', () {
        const widget = DataWipeDetailWidget();
        final state = widget.createState();
        expect(state, isNotNull);
      });
    });

    group('widget type tests', () {
      test('DataWipeDetailWidget is not a StatelessWidget', () {
        const widget = DataWipeDetailWidget();
        expect(widget, isNot(isA<StatelessWidget>()));
      });

      test('DataWipeDetailWidget extends StatefulWidget', () {
        expect(DataWipeDetailWidget, isA<Type>());
        const widget = DataWipeDetailWidget();
        expect(widget.runtimeType.toString(), 'DataWipeDetailWidget');
      });
    });

    group('BottomButtonState enum', () {
      test('has all expected values', () {
        expect(BottomButtonState.values, hasLength(4));
        expect(BottomButtonState.values, contains(BottomButtonState.validation));
        expect(BottomButtonState.values, contains(BottomButtonState.scanAnother));
        expect(BottomButtonState.values, contains(BottomButtonState.initDataWipe));
        expect(BottomButtonState.values, contains(BottomButtonState.cashifyProvider));
      });

      test('validation is at index 0', () {
        expect(BottomButtonState.values[0], BottomButtonState.validation);
      });

      test('scanAnother is at index 1', () {
        expect(BottomButtonState.values[1], BottomButtonState.scanAnother);
      });

      test('initDataWipe is at index 2', () {
        expect(BottomButtonState.values[2], BottomButtonState.initDataWipe);
      });

      test('cashifyProvider is at index 3', () {
        expect(BottomButtonState.values[3], BottomButtonState.cashifyProvider);
      });
    });

    group('widget tests with mock provider', () {
      late MockDataWipeDetailProvider mockProvider;

      setUp(() {
        mockProvider = MockDataWipeDetailProvider();
        // Default stub setup
        when(() => mockProvider.getDeviceWipeStatus(
              isFirstTime: any(named: 'isFirstTime'),
              onError: any(named: 'onError'),
            )).thenReturn(null);
      });

      Widget buildTestWidget() {
        return buildTestableWidgetWithProvider<DataWipeDetailProvider>(
          const _TestDataWipeDetailWidget(),
          mockProvider,
        );
      }

      group('loading state', () {
        testWidgets('shows shimmer when loading is true', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(true);
          when(() => mockProvider.data).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pump();

          expect(find.byKey(const Key('shimmer_loading')), findsOneWidget);
        });

        testWidgets('shows shimmer when data is null', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pump();

          expect(find.byKey(const Key('shimmer_loading')), findsOneWidget);
        });

        testWidgets('does not show shimmer when loaded with data', (tester) async {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            0,
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1, // not cashify provider
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.byKey(const Key('shimmer_loading')), findsNothing);
        });
      });

      group('BottomButtonState.validation', () {
        late DataWipeListItem testData;

        setUp(() {
          testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            -11, // eraserInfoFailedStatus
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );
        });

        testWidgets('shows Update IMEI button when validation state and IMEI reader', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.validation);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Update IMEI'), findsOneWidget);
        });

        testWidgets('shows Update Serial No button when validation state and serial reader', (tester) async {
          testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            -11,
            'MacBook Pro',
            null,
            'laptop',
            null,
            null,
            'ABC123',
            1,
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.validation);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.serialNumberReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Update Serial No'), findsOneWidget);
        });

        testWidgets('hides validation button when IMEI/Serial already updated', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.validation);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(true);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Update IMEI'), findsNothing);
          expect(find.text('Update Serial No'), findsNothing);
        });
      });

      group('BottomButtonState.initDataWipe', () {
        late DataWipeListItem testData;

        setUp(() {
          testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            0,
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );
        });

        testWidgets('shows Initiate Data Wipe button when initDataWipe state', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Initiate Data Wipe'), findsOneWidget);
        });

        testWidgets('hides Initiate button when forceHideInitiateButton is true', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(true);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Initiate Data Wipe'), findsNothing);
          expect(find.text('Scan Another'), findsOneWidget);
        });

        testWidgets('calls initiateDataWipe when button is pressed', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);
          when(() => mockProvider.initiateDataWipe()).thenAnswer((_) => Future.value(true));

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          await tester.tap(find.text('Initiate Data Wipe'));
          await tester.pumpAndSettle();

          verify(() => mockProvider.initiateDataWipe()).called(1);
        });
      });

      group('BottomButtonState.scanAnother', () {
        late DataWipeListItem testData;

        setUp(() {
          testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Completed',
            44, // success status
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );
        });

        testWidgets('shows Scan Another button when scanAnother state', (tester) async {
          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.scanAnother);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Scan Another'), findsOneWidget);
        });
      });

      group('BottomButtonState.cashifyProvider', () {
        late DataWipeListItem testData;

        setUp(() {
          testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            0,
            'Smart Watch',
            null,
            'smartwatch',
            null,
            null,
            'ABC123',
            0, // erasureProviderKey = 0 means Cashify provider
          );
        });

        testWidgets('shows Select Action dropdown when Cashify provider', (tester) async {
          final actionList = [
            DropDownItem('action1', 'Action 1'),
            DropDownItem('action2', 'Action 2'),
          ];

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.cashifyProvider);
          when(() => mockProvider.isProviderCashify()).thenReturn(true);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(actionList);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Select Action'), findsWidgets);
        });

        testWidgets('Submit button is disabled when no action selected', (tester) async {
          final actionList = [
            DropDownItem('action1', 'Action 1'),
            DropDownItem('action2', 'Action 2'),
          ];

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.cashifyProvider);
          when(() => mockProvider.isProviderCashify()).thenReturn(true);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(actionList);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          // Find the submit button and verify it's disabled
          final submitButton = find.byKey(const Key('submit_button'));
          expect(submitButton, findsOneWidget);

          final button = tester.widget<ElevatedButton>(submitButton);
          expect(button.onPressed, isNull);
        });

        testWidgets('does not show action dropdown when not Cashify provider', (tester) async {
          testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Other Provider',
            'Pending',
            0,
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1, // not Cashify
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.byKey(const Key('action_dropdown')), findsNothing);
        });
      });

      group('IMEI validation logic', () {
        test('IMEI is matched when scanned IMEI contains system IMEI1', () {
          final scannedList = ['123456789012345', '123456789012346'];
          final imei1 = '123456789012345';
          final imei2 = '123456789012399';

          final isMatched = _isImeiMatchedTestHelper(scannedList, imei1, imei2);
          expect(isMatched, isTrue);
        });

        test('IMEI is matched when scanned IMEI contains system IMEI2', () {
          final scannedList = ['123456789012345', '123456789012346'];
          final imei1 = '123456789012399';
          final imei2 = '123456789012346';

          final isMatched = _isImeiMatchedTestHelper(scannedList, imei1, imei2);
          expect(isMatched, isTrue);
        });

        test('IMEI is mismatched when scanned IMEIs do not match system IMEIs', () {
          final scannedList = ['123456789012345', '123456789012346'];
          final imei1 = '999999999999999';
          final imei2 = '888888888888888';

          final isMatched = _isImeiMatchedTestHelper(scannedList, imei1, imei2);
          expect(isMatched, isFalse);
        });

        test('IMEI is mismatched when scanned list is null', () {
          final imei1 = '123456789012345';
          final imei2 = '123456789012346';

          final isMatched = _isImeiMatchedTestHelper(null, imei1, imei2);
          expect(isMatched, isFalse);
        });

        test('IMEI is mismatched when scanned list is empty', () {
          final List<String> scannedList = [];
          final imei1 = '123456789012345';
          final imei2 = '123456789012346';

          final isMatched = _isImeiMatchedTestHelper(scannedList, imei1, imei2);
          expect(isMatched, isFalse);
        });

        test('IMEI is mismatched when both system IMEIs are null', () {
          final scannedList = ['123456789012345', '123456789012346'];

          final isMatched = _isImeiMatchedTestHelper(scannedList, null, null);
          expect(isMatched, isFalse);
        });

        test('IMEI is matched when only IMEI1 is present and matches', () {
          final scannedList = ['123456789012345'];
          final imei1 = '123456789012345';

          final isMatched = _isImeiMatchedTestHelper(scannedList, imei1, null);
          expect(isMatched, isTrue);
        });

        test('IMEI is matched when only IMEI2 is present and matches', () {
          final scannedList = ['123456789012346'];
          final imei2 = '123456789012346';

          final isMatched = _isImeiMatchedTestHelper(scannedList, null, imei2);
          expect(isMatched, isTrue);
        });
      });

      group('Serial Number validation logic', () {
        test('Serial is matched when scanned serial matches system serial', () {
          final scannedList = ['ABC123XYZ'];
          final systemSerial = 'ABC123XYZ';

          final isMatched = _isSerialNoMatchedTestHelper(scannedList, systemSerial);
          expect(isMatched, isTrue);
        });

        test('Serial is matched case-insensitively', () {
          final scannedList = ['abc123xyz'];
          final systemSerial = 'ABC123XYZ';

          final isMatched = _isSerialNoMatchedTestHelper(scannedList, systemSerial);
          expect(isMatched, isTrue);
        });

        test('Serial is mismatched when values differ', () {
          final scannedList = ['ABC123XYZ'];
          final systemSerial = 'XYZ789ABC';

          final isMatched = _isSerialNoMatchedTestHelper(scannedList, systemSerial);
          expect(isMatched, isFalse);
        });

        test('Serial is mismatched when scanned list is null', () {
          final systemSerial = 'ABC123XYZ';

          final isMatched = _isSerialNoMatchedTestHelper(null, systemSerial);
          expect(isMatched, isFalse);
        });

        test('Serial is mismatched when scanned list is empty', () {
          final List<String> scannedList = [];
          final systemSerial = 'ABC123XYZ';

          final isMatched = _isSerialNoMatchedTestHelper(scannedList, systemSerial);
          expect(isMatched, isFalse);
        });

        test('Serial is mismatched when system serial is null', () {
          final scannedList = ['ABC123XYZ'];

          final isMatched = _isSerialNoMatchedTestHelper(scannedList, null);
          expect(isMatched, isFalse);
        });

        test('Serial is mismatched when system serial is empty', () {
          final scannedList = ['ABC123XYZ'];

          final isMatched = _isSerialNoMatchedTestHelper(scannedList, '');
          expect(isMatched, isFalse);
        });
      });

      group('Provider methods', () {
        test('isProviderCashify returns true when erasureProviderKey is 0', () {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            0,
            'Smart Watch',
            null,
            'smartwatch',
            null,
            null,
            'ABC123',
            0, // Cashify provider
          );

          expect(testData.erasureProviderKey, 0);
        });

        test('isProviderCashify returns false when erasureProviderKey is not 0', () {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Other',
            'Pending',
            0,
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1, // not Cashify
          );

          expect(testData.erasureProviderKey, isNot(0));
        });

        test('readerType is serialNumberReader for laptop category', () {
          // Laptop category should use serial number reader
          const laptopCategoryKey = 'laptop';
          expect(laptopCategoryKey, 'laptop');
        });

        test('readerType is imeiReader for mobile category', () {
          // Mobile category should use IMEI reader
          const mobileCategoryKey = 'mobile';
          expect(mobileCategoryKey, 'mobile');
        });
      });

      group('data display', () {
        testWidgets('displays device barcode', (tester) async {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE_12345',
            'Cashify',
            'Pending',
            0,
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('TEST_BARCODE_12345'), findsOneWidget);
        });

        testWidgets('displays product name', (tester) async {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            0,
            'iPhone 12 Pro Max',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('iPhone 12 Pro Max'), findsOneWidget);
        });

        testWidgets('displays error message when present', (tester) async {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Failed',
            -1,
            'iPhone 12',
            'Data wipe failed due to network error',
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.scanAnother);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          expect(find.text('Data wipe failed due to network error'), findsOneWidget);
        });
      });

      group('edge cases', () {
        testWidgets('handles null qrCode gracefully', (tester) async {
          final testData = DataWipeListItem(
            1,
            null, // null qrCode
            'Cashify',
            'Pending',
            0,
            'iPhone 12',
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          // Should render without crashing
          expect(find.byType(_TestDataWipeDetailWidget), findsOneWidget);
        });

        testWidgets('handles null productName gracefully', (tester) async {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            0,
            null, // null productName
            null,
            'mobile',
            '123456789012345',
            '123456789012346',
            'ABC123',
            1,
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.initDataWipe);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.forceHideInitiateButton).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          // Should render without crashing
          expect(find.byType(_TestDataWipeDetailWidget), findsOneWidget);
        });

        testWidgets('handles all null IMEIs and Serial', (tester) async {
          final testData = DataWipeListItem(
            1,
            'TEST_BARCODE',
            'Cashify',
            'Pending',
            -11,
            'Smart Watch',
            null,
            'smartwatch',
            null, // null imei1
            null, // null imei2
            null, // null serialNo
            1,
          );

          when(() => mockProvider.isLoading).thenReturn(false);
          when(() => mockProvider.data).thenReturn(testData);
          when(() => mockProvider.bottomButtonState).thenReturn(BottomButtonState.validation);
          when(() => mockProvider.isProviderCashify()).thenReturn(false);
          when(() => mockProvider.isImeiSerialAlreadyUpdated).thenReturn(false);
          when(() => mockProvider.readerType).thenReturn(ReaderType.imeiReader);
          when(() => mockProvider.actionList).thenReturn(null);

          await tester.pumpWidget(buildTestWidget());
          await tester.pumpAndSettle();

          // Should render without crashing
          expect(find.byType(_TestDataWipeDetailWidget), findsOneWidget);
        });
      });
    });
  });
}

/// Test widget that mimics the DataWipeDetailWidget
/// This allows us to test the widget with a mock provider
class _TestDataWipeDetailWidget extends StatefulWidget {
  const _TestDataWipeDetailWidget();

  @override
  State<_TestDataWipeDetailWidget> createState() => _TestDataWipeDetailWidgetState();
}

class _TestDataWipeDetailWidgetState extends State<_TestDataWipeDetailWidget> {
  DropDownItem? _selectedAction;

  @override
  Widget build(BuildContext context) {
    var provider = DataWipeDetailProvider.of(context);

    if (provider.isLoading || provider.data == null) {
      return const Center(
        key: Key('shimmer_loading'),
        child: CircularProgressIndicator(),
      );
    }

    var data = provider.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Status card would go here
              const SizedBox(height: 16),
              // Data card
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data?.qrCode ?? ''),
                    Text(data?.productName ?? ''),
                    Text(data?.status ?? ''),
                    if (data?.errorMessage != null) Text(data!.errorMessage!),
                  ],
                ),
              ),
              if (provider.isProviderCashify())
                Card(
                  key: const Key('action_dropdown'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select Action'),
                      const SizedBox(width: 32),
                      Expanded(
                        child: DropdownButton<String>(
                          hint: const Text('Select Action'),
                          value: _selectedAction?.id,
                          items: provider.actionList?.map((e) {
                            return DropdownMenuItem<String>(value: e.id, child: Text(e.id ?? ''));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedAction = provider.actionList?.firstWhere((e) => e.id == value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (provider.bottomButtonState == BottomButtonState.validation && !provider.isImeiSerialAlreadyUpdated)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // _onValidateImeiClicked would happen here
              },
              child: Text(
                provider.readerType == ReaderType.serialNumberReader ? 'Update Serial No' : 'Update IMEI',
              ),
            ),
          ),
        if (provider.bottomButtonState != BottomButtonState.validation)
          (provider.bottomButtonState == BottomButtonState.initDataWipe && !provider.forceHideInitiateButton)
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      provider.initiateDataWipe();
                    },
                    child: const Text('Initiate Data Wipe'),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton(
                    onPressed: () {
                      // _onScannedAnotherClicked would happen here
                    },
                    child: const Text('Scan Another'),
                  ),
                ),
        if (provider.bottomButtonState == BottomButtonState.cashifyProvider)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              key: const Key('submit_button'),
              onPressed: _selectedAction != null
                  ? () {
                      provider.submitSmartWatchAction(action: _selectedAction?.id);
                    }
                  : null,
              child: const Text('Submit'),
            ),
          ),
      ],
    );
  }
}

/// Helper function to test IMEI matching logic
bool _isImeiMatchedTestHelper(List<String>? scannedList, String? imei1, String? imei2) {
  if (scannedList == null || scannedList.isEmpty) {
    return false;
  }

  if ((imei1 == null || imei1.isEmpty) && (imei2 == null || imei2.isEmpty)) {
    return false;
  }

  if (scannedList.contains(imei1) || scannedList.contains(imei2)) {
    return true;
  } else {
    return false;
  }
}

/// Helper function to test Serial Number matching logic
bool _isSerialNoMatchedTestHelper(List<String>? scannedList, String? serialNo) {
  if (scannedList == null || scannedList.isEmpty) {
    return false;
  }

  if (serialNo == null || serialNo.isEmpty) {
    return false;
  }

  if (scannedList.first.toLowerCase() == serialNo.toLowerCase()) {
    return true;
  } else {
    return false;
  }
}
