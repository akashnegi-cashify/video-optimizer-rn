import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/labeled_text.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('LabeledText', () {
    testWidgets('renders correctly with label and value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Test Label',
            value: 'Test Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LabeledText), findsOneWidget);
      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Value'), findsOneWidget);
    });

    testWidgets('returns SizedBox.shrink when value is null', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Test Label',
            value: null,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Widget should render as SizedBox.shrink (empty)
      expect(find.text('Test Label'), findsNothing);
    });

    testWidgets('returns SizedBox.shrink when value is empty string', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Test Label',
            value: '',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should render SizedBox.shrink for empty value
      expect(find.text('Test Label'), findsNothing);
    });

    testWidgets('renders with custom label text style', (tester) async {
      const customStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Custom Label',
            value: 'Value',
            labelTextStyle: customStyle,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LabeledText), findsOneWidget);
      expect(find.text('Custom Label'), findsOneWidget);
    });

    testWidgets('renders with custom value text style', (tester) async {
      const customStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.blue,
      );
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Custom Value',
            valueTextStyle: customStyle,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LabeledText), findsOneWidget);
      expect(find.text('Custom Value'), findsOneWidget);
    });

    testWidgets('renders with custom label flex', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
            labelFlex: 2,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LabeledText), findsOneWidget);
      // Verify Expanded widgets are present
      expect(find.byType(Expanded), findsNWidgets(2));
    });

    testWidgets('renders with custom value flex', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
            valueFlex: 3,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LabeledText), findsOneWidget);
    });

    testWidgets('renders with custom crossAxisAlignment', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('uses default crossAxisAlignment center', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.crossAxisAlignment, CrossAxisAlignment.center);
    });

    testWidgets('renders with custom padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
            padding: EdgeInsets.all(8),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(8));
    });

    testWidgets('uses default padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(
        padding.padding,
        const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
      );
    });

    testWidgets('renders with all custom parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Custom Label',
            value: 'Custom Value',
            labelTextStyle: TextStyle(fontSize: 14),
            valueTextStyle: TextStyle(fontSize: 16),
            labelFlex: 2,
            valueFlex: 3,
            crossAxisAlignment: CrossAxisAlignment.end,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LabeledText), findsOneWidget);
      expect(find.text('Custom Label'), findsOneWidget);
      expect(find.text('Custom Value'), findsOneWidget);
    });

    testWidgets('renders with default flex values', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final expandedWidgets = tester.widgetList<Expanded>(find.byType(Expanded)).toList();
      expect(expandedWidgets.length, 2);
      // Both should have default flex of 1
      expect(expandedWidgets[0].flex, 1);
      expect(expandedWidgets[1].flex, 1);
    });

    testWidgets('renders CshTextNew widgets for label and value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshTextNew), findsNWidgets(2));
    });

    testWidgets('renders with whitespace value (non-empty)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: '   ',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Whitespace-only string should still render (not empty check)
      expect(find.byType(LabeledText), findsOneWidget);
    });

    testWidgets('renders Row with proper structure', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const LabeledText(
            label: 'Label',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Expanded), findsNWidgets(2));
    });
  });
}
