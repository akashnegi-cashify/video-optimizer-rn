import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/widgets/delivery_receive_list_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/providers/delivery_receive_provider.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/receive_response_model.dart';

class MockDeliveryReceiveProvider extends Mock
    implements DeliveryReceiveProvider {}

void main() {
  late MockDeliveryReceiveProvider mockDeliveryReceiveProvider;

  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<DeliveryReceiveProvider>.value(
            value: mockDeliveryReceiveProvider),
      ],
      child: MaterialApp(
        theme: ThemeData(
          extensions: [
            CustomColors(
              successColor: Colors.green,
              warnColor: Colors.orange,
              inputStrokeColor: Colors.grey,
              searchShadow: Colors.grey.withAlpha(50),
              shadows: const {},
            ),
          ],
        ),
        home: Scaffold(body: child),
      ),
    );
  }

  setUp(() {
    mockDeliveryReceiveProvider = MockDeliveryReceiveProvider();

    // Mock provider listener
    when(() => mockDeliveryReceiveProvider.addListener(any())).thenReturn(null);
    when(() => mockDeliveryReceiveProvider.removeListener(any()))
        .thenReturn(null);
  });

  group('DeliveryReceiveListWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester
          .pumpWidget(buildTestWidget(const DeliveryReceiveListWidget()));
      await tester.pump();

      expect(find.byType(DeliveryReceiveListWidget), findsOneWidget);
    });

    testWidgets('uses CshApiList for rendering', (tester) async {
      await tester
          .pumpWidget(buildTestWidget(const DeliveryReceiveListWidget()));
      await tester.pump();

      expect(find.byType(CshApiList<Part>), findsOneWidget);
    });

    testWidgets('listens to provider changes', (tester) async {
      await tester
          .pumpWidget(buildTestWidget(const DeliveryReceiveListWidget()));
      await tester.pump();

      verify(() => mockDeliveryReceiveProvider.addListener(any())).called(1);
    });
  });
}
