import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/widgets/pickup_receive_engineer_parts_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/models/pickup_receive_engineer_parts_param.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:flutter_trc/src/modules/rider/engineer_card_widget.dart';

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
    return EngineerDetail.fromJson({
      'id': id,
      'n': name,
      'lc': location,
    });
  }

  PickUpReceiveEngineerPartsParams createParams({
    required EngineerDetail engineerDetail,
  }) {
    return PickUpReceiveEngineerPartsParams(engineerDetail: engineerDetail);
  }

  group('PickupReceiveEngineerPartsWidget', () {
    testWidgets('renders without error with valid param', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.byType(PickupReceiveEngineerPartsWidget), findsOneWidget);
    });

    testWidgets('displays EngineerCardWidget', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.byType(EngineerCardWidget), findsOneWidget);
    });

    testWidgets('displays Column layout', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('displays Expanded widget for parts list', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.byType(Expanded), findsAtLeastNWidgets(1));
    });

    testWidgets('displays engineer name', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'Jane Smith',
        location: 'Delhi',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.text('Jane Smith'), findsOneWidget);
    });

    testWidgets('displays engineer location', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'Jane Smith',
        location: 'Chennai',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.text('Chennai'), findsOneWidget);
    });

    testWidgets('uses StreamBuilder for parts list', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John Doe',
        location: 'Mumbai',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.byType(StreamBuilder), findsAtLeastNWidgets(1));
    });

    testWidgets('handles engineer with null name', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: null,
        location: 'Mumbai',
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.byType(PickupReceiveEngineerPartsWidget), findsOneWidget);
    });

    testWidgets('handles engineer with null location', (tester) async {
      final detail = createEngineerDetail(
        id: 1,
        name: 'John',
        location: null,
      );
      final params = createParams(engineerDetail: detail);

      await tester.pumpWidget(buildTestWidget(
        PickupReceiveEngineerPartsWidget(paramModel: params),
      ));
      await tester.pump();

      expect(find.byType(PickupReceiveEngineerPartsWidget), findsOneWidget);
    });
  });
}
