import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/engineer_card_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:flutter_trc/src/common/widgets/key_value_row_widget.dart';

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

  EngineerDetail createEngineerDetail({
    int id = 1,
    String? name,
    String? location,
  }) {
    final detail = EngineerDetail.fromJson({
      'id': id,
      'n': name,
      'lc': location,
    });
    return detail;
  }

  group('EngineerCardWidget', () {
    testWidgets('renders without error', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.byType(EngineerCardWidget), findsOneWidget);
    });

    testWidgets('displays engineer name', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('displays engineer location', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.text('Mumbai'), findsOneWidget);
    });

    testWidgets('displays CshCard wrapper', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('displays two KeyValueRowWidgets', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.byType(KeyValueRowWidget), findsNWidgets(2));
    });

    testWidgets('handles null name gracefully', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: null,
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      // Should display empty string for null name
      expect(find.byType(EngineerCardWidget), findsOneWidget);
    });

    testWidgets('handles null location gracefully', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: null,
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      // Should display empty string for null location
      expect(find.byType(EngineerCardWidget), findsOneWidget);
    });

    testWidgets('handles both null name and location gracefully',
        (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: null,
        location: null,
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.byType(EngineerCardWidget), findsOneWidget);
      expect(find.byType(KeyValueRowWidget), findsNWidgets(2));
    });

    testWidgets('displays special characters in name', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: "O'Brien Müller",
        location: 'München',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.text("O'Brien Müller"), findsOneWidget);
      expect(find.text('München'), findsOneWidget);
    });

    testWidgets('displays long name without overflow', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'This is a very long engineer name that should be handled properly',
        location: 'This is a very long location name',
      );

      await tester.pumpWidget(buildTestWidget(
        EngineerCardWidget(detail: detail),
      ));
      await tester.pump();

      expect(find.byType(EngineerCardWidget), findsOneWidget);
    });
  });
}
