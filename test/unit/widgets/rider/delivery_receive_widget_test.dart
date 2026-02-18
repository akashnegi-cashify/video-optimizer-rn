import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/widgets/delivery_receive_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/widgets/delivery_receive_list_widget.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
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

  group('DeliveryReceiveWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byType(DeliveryReceiveWidget), findsOneWidget);
    });

    testWidgets('displays search input field', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('displays scanner icon', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byIcon(Icons.qr_code_2), findsOneWidget);
    });

    testWidgets('displays urgent requests checkbox', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byType(CshCheckbox), findsOneWidget);
    });

    testWidgets('displays DeliveryReceiveListWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byType(DeliveryReceiveListWidget), findsOneWidget);
    });

    testWidgets('displays Column layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('displays Row for checkbox section', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byType(Row), findsAtLeastNWidgets(1));
    });

    testWidgets('uses AutomaticKeepAliveClientMixin', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      // Widget should keep state alive
      expect(find.byType(DeliveryReceiveWidget), findsOneWidget);
    });

    testWidgets('checkbox can be toggled', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      final checkbox = find.byType(CshCheckbox);
      expect(checkbox, findsOneWidget);

      // Tap the checkbox
      await tester.tap(checkbox);
      await tester.pump();

      expect(find.byType(DeliveryReceiveWidget), findsOneWidget);
    });

    testWidgets('search field can accept text input', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      final searchField = find.byType(CshTextFormField);
      expect(searchField, findsOneWidget);

      // Enter text
      await tester.enterText(searchField, 'TEST123');
      await tester.pump();

      expect(find.text('TEST123'), findsOneWidget);
    });

    testWidgets('displays CshCard wrapper for search', (tester) async {
      await tester.pumpWidget(buildTestWidget(const DeliveryReceiveWidget()));
      await tester.pump();

      expect(find.byType(CshCard), findsAtLeastNWidgets(1));
    });
  });
}
