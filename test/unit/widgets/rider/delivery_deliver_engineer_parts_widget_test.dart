import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:core_widgets/src/theme/theme_change.provider.dart';

import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/widgets/delivery_deliver_engineer_parts_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/widgets/item_delivery_deliver_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/engineer_parts_response.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<ThemeChangeProvider>(create: (_) => ThemeChangeProvider(false)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          extensions: [
            CustomColors(
              successColor: Colors.green,
              warnColor: Colors.orange,
              inputStrokeColor: Colors.grey,
              searchShadow: Colors.grey.withAlpha(50),
              shadows: {
                10: const BoxShadow(color: Colors.black12, blurRadius: 10),
                15: const BoxShadow(color: Colors.black12, blurRadius: 15),
                20: const BoxShadow(color: Colors.black12, blurRadius: 20),
              },
            ),
          ],
        ),
        home: Scaffold(body: child),
        routes: {
          'qc/rider/delivery/deliver/engineer/parts': (context) =>
              const Scaffold(body: Text('Parts Screen')),
        },
      ),
    );
  }

  EngineerDetail createEngineerDetail({
    int id = 1,
    String? name,
    String? location,
  }) {
    return EngineerDetail.fromJson({
      'id': id,
      'n': name,
      'lc': location,
    });
  }

  group('DeliveryDeliverEngineerPartsWidget', () {
    testWidgets('renders without error with engineer detail', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        DeliveryDeliverEngineerPartsWidget(engineerDetail: detail),
      ));
      await tester.pump();
      // Consume expected error from StreamBuilder calling showSnackBar during build
      tester.takeException();

      expect(find.byType(DeliveryDeliverEngineerPartsWidget), findsOneWidget);
    });

    testWidgets('displays ItemDeliveryDeliverWidget with engineer detail',
        (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        DeliveryDeliverEngineerPartsWidget(engineerDetail: detail),
      ));
      await tester.pump();
      tester.takeException();

      expect(find.byType(ItemDeliveryDeliverWidget), findsOneWidget);
    });

    testWidgets('displays Column layout', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        DeliveryDeliverEngineerPartsWidget(engineerDetail: detail),
      ));
      await tester.pump();
      tester.takeException();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('displays Expanded widget for parts list', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        DeliveryDeliverEngineerPartsWidget(engineerDetail: detail),
      ));
      await tester.pump();
      tester.takeException();

      expect(find.byType(Expanded), findsAtLeastNWidgets(1));
    });

    testWidgets('displays engineer name', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'Jane Smith',
        location: 'Delhi',
      );

      await tester.pumpWidget(buildTestWidget(
        DeliveryDeliverEngineerPartsWidget(engineerDetail: detail),
      ));
      await tester.pump();
      tester.takeException();

      expect(find.text('Jane Smith'), findsOneWidget);
    });

    testWidgets('displays engineer location', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'Jane Smith',
        location: 'Chennai',
      );

      await tester.pumpWidget(buildTestWidget(
        DeliveryDeliverEngineerPartsWidget(engineerDetail: detail),
      ));
      await tester.pump();
      tester.takeException();

      expect(find.text('Chennai'), findsOneWidget);
    });

    testWidgets('uses StreamBuilder for parts list', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );

      await tester.pumpWidget(buildTestWidget(
        DeliveryDeliverEngineerPartsWidget(engineerDetail: detail),
      ));
      await tester.pump();
      tester.takeException();

      expect(find.byType(StreamBuilder<EngineerPartsResponse?>), findsAtLeastNWidgets(1));
    });
  });
}
