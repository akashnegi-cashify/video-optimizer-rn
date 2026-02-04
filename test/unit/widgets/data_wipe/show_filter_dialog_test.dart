import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;

// ignore: deprecated_member_use_from_same_package
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_filter_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';

void main() {
  group('showFilterDialog (deprecated)', () {
    Widget buildTestWidget({
      required Widget Function(BuildContext) builder,
    }) {
      return MaterialApp(
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
        home: Builder(
          builder: (context) => Scaffold(
            body: builder(context),
          ),
        ),
      );
    }

    testWidgets('shows dialog when called', (tester) async {
      Map<String, List<DataWipFilterListItem>>? appliedFilter;

      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            // ignore: deprecated_member_use_from_same_package
            showFilterDialog(
              context,
              onFilterApplied: (filter) {
                appliedFilter = filter;
              },
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Filters'), findsOneWidget);
    });

    testWidgets('shows dialog with preselected filters', (tester) async {
      final preSelectedFilter = <String, List<DataWipFilterListItem>>{
        'status': [
          DataWipFilterListItem.fromJson({'id': '1', 'label': 'Pending'})
        ],
      };

      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            // ignore: deprecated_member_use_from_same_package
            showFilterDialog(
              context,
              selectedFilter: preSelectedFilter,
              onFilterApplied: (filter) {},
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Filters'), findsOneWidget);
    });

    testWidgets('shows dialog with null preselected filters', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            // ignore: deprecated_member_use_from_same_package
            showFilterDialog(
              context,
              selectedFilter: null,
              onFilterApplied: (filter) {},
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Filters'), findsOneWidget);
    });

    testWidgets('has close icon to dismiss', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            // ignore: deprecated_member_use_from_same_package
            showFilterDialog(
              context,
              onFilterApplied: (filter) {},
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      // Find CshIcon for close button
      expect(find.byType(CshIcon), findsWidgets);
    });
  });
}
