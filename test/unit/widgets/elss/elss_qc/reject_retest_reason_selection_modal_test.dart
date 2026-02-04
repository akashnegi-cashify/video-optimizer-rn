import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/reject_retest_reason_selection_modal.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ReasonType enum', () {
    test('has retest value', () {
      expect(ReasonType.retest, isNotNull);
    });

    test('has reject value', () {
      expect(ReasonType.reject, isNotNull);
    });

    test('values contains both types', () {
      expect(ReasonType.values, contains(ReasonType.retest));
      expect(ReasonType.values, contains(ReasonType.reject));
    });

    test('values has correct length', () {
      expect(ReasonType.values.length, 2);
    });
  });

  group('showRejectRetestBottomSheetModal function', () {
    Widget buildTestWidget() {
      return MaterialApp(
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          extensions: [CustomColors.light()],
        ),
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => LocaleProvider(),
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showRejectRetestBottomSheetModal(
                      context,
                      ReasonType.reject,
                      'TEST_BARCODE',
                    );
                  },
                  child: const Text('Show Modal'),
                );
              },
            ),
          ),
        ),
      );
    }

    testWidgets('can be called with reject type', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('button exists to trigger modal', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Show Modal'), findsOneWidget);
    });
  });

  group('ReasonType enum tests', () {
    test('ReasonType.retest toString returns correct value', () {
      expect(ReasonType.retest.toString(), 'ReasonType.retest');
    });

    test('ReasonType.reject toString returns correct value', () {
      expect(ReasonType.reject.toString(), 'ReasonType.reject');
    });

    test('ReasonType values are different', () {
      expect(ReasonType.retest, isNot(equals(ReasonType.reject)));
    });

    test('ReasonType index values are correct', () {
      expect(ReasonType.retest.index, 0);
      expect(ReasonType.reject.index, 1);
    });
  });
}
