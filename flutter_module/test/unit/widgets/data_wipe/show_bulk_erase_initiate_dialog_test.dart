import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_bulk_erase_initiate_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';

void main() {
  group('showBulkEraseInitiateDialog', () {
    late List<DataWipFilterListItem> statusList;

    setUp(() {
      statusList = [
        DataWipFilterListItem.fromJson({'k': 1, 'v': 'CASHIFY'}),
        DataWipFilterListItem.fromJson({'k': 2, 'v': 'BLANCCO'}),
        DataWipFilterListItem.fromJson({'k': 3, 'v': 'OTHER'}),
      ];
    });

    Widget buildTestWidget({
      required Widget Function(BuildContext) builder,
    }) {
      return MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: builder(context),
          ),
        ),
      );
    }

    testWidgets('shows dialog when called', (tester) async {
      DataWipFilterListItem? selectedStatus;

      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            showBulkEraseInitiateDialog(
              context,
              statusList,
              onProceed: (status) {
                selectedStatus = status;
              },
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Initiate Bulk Erase'), findsOneWidget);
    });

    testWidgets('displays all status items', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            showBulkEraseInitiateDialog(
              context,
              statusList,
              onProceed: (status) {},
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('CASHIFY'), findsOneWidget);
      expect(find.text('BLANCCO'), findsOneWidget);
      expect(find.text('OTHER'), findsOneWidget);
    });

    testWidgets('calls onProceed when item is tapped', (tester) async {
      DataWipFilterListItem? selectedStatus;

      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            showBulkEraseInitiateDialog(
              context,
              statusList,
              onProceed: (status) {
                selectedStatus = status;
              },
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('CASHIFY'));
      await tester.pump();

      expect(selectedStatus?.label, 'CASHIFY');
    });

    testWidgets('displays items with null labels gracefully', (tester) async {
      final listWithNullLabel = [
        DataWipFilterListItem.fromJson({'k': 1, 'v': null}),
      ];

      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            showBulkEraseInitiateDialog(
              context,
              listWithNullLabel,
              onProceed: (status) {},
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Initiate Bulk Erase'), findsOneWidget);
    });

    testWidgets('handles empty status list', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            showBulkEraseInitiateDialog(
              context,
              [],
              onProceed: (status) {},
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Initiate Bulk Erase'), findsOneWidget);
    });

    testWidgets('tapping second item calls onProceed with correct status', (tester) async {
      DataWipFilterListItem? selectedStatus;

      await tester.pumpWidget(buildTestWidget(
        builder: (context) => ElevatedButton(
          onPressed: () {
            showBulkEraseInitiateDialog(
              context,
              statusList,
              onProceed: (status) {
                selectedStatus = status;
              },
            );
          },
          child: const Text('Open Dialog'),
        ),
      ));

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('BLANCCO'));
      await tester.pump();

      expect(selectedStatus?.label, 'BLANCCO');
    });
  });
}
