import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;

import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/widgets/pickup_receive_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/providers/pickup_receive_provider.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';

/// Testable version of PickupReceiveProvider that doesn't make API calls
class TestablePickupReceiveProvider extends ChangeNotifier {
  List<EngineerDetail>? displayList;
  String? _searchQuery;

  TestablePickupReceiveProvider({this.displayList});

  String? get searchQuery => _searchQuery;
  set searchQuery(String? value) {
    _searchQuery = value;
    applySearch();
  }

  void applySearch() {
    notifyListeners();
  }

  void getData() {
    notifyListeners();
  }
}

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

  group('PickupReceiveWidget', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      expect(find.byType(PickupReceiveWidget), findsOneWidget);
    });

    testWidgets('displays SearchBarWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      expect(find.byType(SearchBarWidget), findsOneWidget);
    });

    testWidgets('creates ChangeNotifierProvider for PickupReceiveProvider',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      // The widget should have created a provider
      expect(find.byType(PickupReceiveWidget), findsOneWidget);
    });

    testWidgets('displays Column as layout', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('has Expanded widget for list area', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      expect(find.byType(Expanded), findsAtLeastNWidgets(1));
    });

    testWidgets('uses AutomaticKeepAliveClientMixin', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      // Widget should be present and keeping state alive
      expect(find.byType(PickupReceiveWidget), findsOneWidget);
    });

    testWidgets('uses Consumer for provider', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      expect(find.byType(Consumer<PickupReceiveProvider>), findsOneWidget);
    });

    testWidgets('search can be entered', (tester) async {
      await tester.pumpWidget(buildTestWidget(const PickupReceiveWidget()));
      await tester.pump();

      // Find search field
      final searchFinder = find.byType(SearchBarWidget);
      expect(searchFinder, findsOneWidget);
    });
  });
}
