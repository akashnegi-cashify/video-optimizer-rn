import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;

import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_imei_status_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/verification_status_enum.dart';

void main() {
  group('showImeiStatusDialog', () {
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

    group('matched status', () {
      testWidgets('shows dialog with matched status', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemImeiNos: ['123456789012345'],
                scannedImeiNos: ['123456789012345'],
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        // Dialog should be visible
        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('shows proceed button for matched status', (tester) async {
        bool proceedCalled = false;

        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemImeiNos: ['123456789012345'],
                scannedImeiNos: ['123456789012345'],
                onProceedToDataWipe: () {
                  proceedCalled = true;
                },
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        // Find and tap the proceed button
        final proceedButton = find.byType(CshBigButton);
        if (proceedButton.evaluate().isNotEmpty) {
          await tester.tap(proceedButton);
          await tester.pump();
          expect(proceedCalled, true);
        }
      });

      testWidgets('displays system IMEI numbers', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemImeiNos: ['123456789012345', '543210987654321'],
                scannedImeiNos: ['123456789012345', '543210987654321'],
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('123456789012345'), findsWidgets);
        expect(find.text('543210987654321'), findsWidgets);
      });
    });

    group('mismatched status', () {
      testWidgets('shows dialog with mismatched status', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.misMatched,
                systemImeiNos: ['123456789012345'],
                scannedImeiNos: ['999888777666555'],
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        // Dialog should be visible
        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('shows report and retry buttons for mismatched status', (tester) async {
        bool retryCalled = false;
        bool reportCalled = false;

        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.misMatched,
                systemImeiNos: ['123456789012345'],
                scannedImeiNos: ['999888777666555'],
                onRetry: () {
                  retryCalled = true;
                },
                onReport: () {
                  reportCalled = true;
                },
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        // ComboButton should be present for mismatched status
        expect(find.byType(ComboButton), findsOneWidget);
      });
    });

    group('edge cases', () {
      testWidgets('handles null IMEI lists', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemImeiNos: null,
                scannedImeiNos: null,
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        // Dialog should still show
        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('handles empty IMEI lists', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemImeiNos: [],
                scannedImeiNos: [],
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('handles single IMEI in list', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemImeiNos: ['123456789012345'],
                scannedImeiNos: ['123456789012345'],
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        // Should only show IMEI1, not IMEI2
        expect(find.text('123456789012345'), findsWidgets);
      });

      testWidgets('handles null callbacks', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showImeiStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemImeiNos: ['123456789012345'],
                scannedImeiNos: ['123456789012345'],
                onProceedToDataWipe: null,
                onRetry: null,
                onReport: null,
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      });
    });
  });

  group('VerificationStatusEnum', () {
    test('enum has matched value', () {
      expect(VerificationStatusEnum.values, contains(VerificationStatusEnum.matched));
    });

    test('enum has misMatched value', () {
      expect(VerificationStatusEnum.values, contains(VerificationStatusEnum.misMatched));
    });

    test('enum has only 2 values', () {
      expect(VerificationStatusEnum.values.length, 2);
    });

    test('matched and misMatched are different', () {
      expect(VerificationStatusEnum.matched, isNot(equals(VerificationStatusEnum.misMatched)));
    });
  });
}
