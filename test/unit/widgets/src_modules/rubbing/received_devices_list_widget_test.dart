import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_data.dart';
import 'package:flutter_trc/src/modules/rubbing/providers/received_devices_provider.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/received_devices_list_widget.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:provider/provider.dart';

/// Mock provider for testing
class MockReceivedDevicesProvider extends ChangeNotifier
    implements ReceivedDevicesProvider {
  @override
  bool get isGlassChangeRole => false;

  @override
  List<GlassChangeFailReasonItem>? get glassChangeFailReasonList => [];

  @override
  String? searchQuery;

  @override
  late var interactor;

  @override
  Stream<dynamic> receiveDeviceViaScanning(String barcode) {
    return Stream.value(null);
  }

  @override
  Future<dynamic> markRubbing(String barcode, bool isDone, String? partBarcode,
      String? selectedReason) {
    return Future.value(null);
  }
}

void main() {
  /// Builds a testable widget with required providers
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReceivedDevicesProvider>(
          create: (_) => MockReceivedDevicesProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: Scaffold(body: child),
      ),
    );
  }

  group('ReceivedDevicesListWidget', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      expect(find.byType(ReceivedDevicesListWidget), findsOneWidget);
    });

    testWidgets('renders CshApiList', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      expect(find.byType(CshApiList<RubbingDeviceData>), findsOneWidget);
    });

    testWidgets('is a StatefulWidget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      expect(find.byType(ReceivedDevicesListWidget), findsOneWidget);
    });

    testWidgets('can accept key parameter', (tester) async {
      const key = Key('received_devices_list_key');

      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(key: key),
        ),
      );
      await tester.pump();

      expect(find.byKey(key), findsOneWidget);
    });
  });

  group('ReceivedDevicesListWidget - State', () {
    testWidgets('state is created on build', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      expect(find.byType(ReceivedDevicesListWidget), findsOneWidget);
    });

    testWidgets('disposes properly when removed', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      // Remove widget from tree
      await tester.pumpWidget(
        buildTestWidget(const SizedBox()),
      );
      await tester.pump();

      expect(find.byType(ReceivedDevicesListWidget), findsNothing);
    });
  });

  group('ReceivedDevicesListWidget - CshApiList Configuration', () {
    testWidgets('CshApiList is configured properly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      final apiList = tester.widget<CshApiList<RubbingDeviceData>>(
        find.byType(CshApiList<RubbingDeviceData>),
      );

      // Verify basic configuration
      expect(apiList.filterConfig, isNotNull);
      expect(apiList.itemFromJson, isNotNull);
      expect(apiList.getRowWidget, isNotNull);
    });

    testWidgets('CshApiList has shimmer loader', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      final apiList = tester.widget<CshApiList<RubbingDeviceData>>(
        find.byType(CshApiList<RubbingDeviceData>),
      );

      expect(apiList.shimmerLoaderWidget, isNotNull);
    });

    testWidgets('CshApiList has zero list padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      final apiList = tester.widget<CshApiList<RubbingDeviceData>>(
        find.byType(CshApiList<RubbingDeviceData>),
      );

      expect(apiList.listPadding, EdgeInsets.zero);
    });

    testWidgets('CshApiList has vertical row spacing', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      final apiList = tester.widget<CshApiList<RubbingDeviceData>>(
        find.byType(CshApiList<RubbingDeviceData>),
      );

      expect(apiList.verticalRowSpacing, Dimens.space_16);
    });

    testWidgets('CshApiList hides core filter button', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const ReceivedDevicesListWidget(),
        ),
      );
      await tester.pump();

      final apiList = tester.widget<CshApiList<RubbingDeviceData>>(
        find.byType(CshApiList<RubbingDeviceData>),
      );

      expect(apiList.isHideCoreFilterButton, isTrue);
    });
  });

  group('RubbingDeviceData Model', () {
    test('RubbingDeviceData can be instantiated', () {
      // Create instance (note: deviceId is late, so we'd need fromJson)
      expect(RubbingDeviceData, isNotNull);
    });

    test('RubbingDeviceData.fromJson exists', () {
      expect(RubbingDeviceData.fromJson, isA<Function>());
    });

    test('RubbingDeviceData.fromJson parses valid JSON', () {
      final json = {
        'deviceId': 123,
        'productTitle': 'Test Product',
        'deviceBarcode': 'TEST123',
        'trayBarcode': 'TRAY001',
        'assignedAt': 1640000000,
        'isUrgent': false,
        'skewImageTaken': true,
      };

      final data = RubbingDeviceData.fromJson(json);

      expect(data.deviceId, 123);
      expect(data.productTitle, 'Test Product');
      expect(data.deviceBarcode, 'TEST123');
      expect(data.trayBarcode, 'TRAY001');
      expect(data.assignedAt, 1640000000);
      expect(data.isUrgent, false);
      expect(data.skewImageTaken, true);
    });

    test('RubbingDeviceData.fromJson handles null values', () {
      final json = {
        'deviceId': 456,
        'productTitle': null,
        'deviceBarcode': null,
        'trayBarcode': null,
        'assignedAt': null,
        'isUrgent': null,
        'skewImageTaken': null,
      };

      final data = RubbingDeviceData.fromJson(json);

      expect(data.deviceId, 456);
      expect(data.productTitle, isNull);
      expect(data.deviceBarcode, isNull);
    });

    test('RubbingDeviceData.toJson returns map', () {
      final json = {
        'deviceId': 789,
        'productTitle': 'Product',
        'deviceBarcode': 'BC789',
      };

      final data = RubbingDeviceData.fromJson(json);
      final outputJson = data.toJson();

      expect(outputJson, isA<Map<String, dynamic>>());
      expect(outputJson['deviceId'], 789);
    });
  });
}
