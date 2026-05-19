import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/key_value_row_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('KeyValueRowWidget', () {
    testWidgets('renders correctly with title and value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Test Title',
            value: 'Test Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(KeyValueRowWidget), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Value'), findsOneWidget);
    });

    testWidgets('renders Row with spaceBetween alignment', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });

    testWidgets('renders value in Expanded widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('truncates long value text with ellipsis', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            width: 200,
            child: KeyValueRowWidget(
              title: 'Title',
              value: 'This is a very long value text that should be truncated',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('This is a very long value text that should be truncated'));
      expect(text.maxLines, 1);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets('renders with empty title', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: '',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(KeyValueRowWidget), findsOneWidget);
      expect(find.text('Value'), findsOneWidget);
    });

    testWidgets('renders with empty value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Title',
            value: '',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(KeyValueRowWidget), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('renders CshTextNew for title', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Title Text',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshTextNew), findsWidgets);
    });

    testWidgets('renders SizedBox for spacing', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find SizedBox with specific width
      final sizedBox = find.byWidgetPredicate((widget) =>
          widget is SizedBox && widget.width == Dimens.space_6);
      expect(sizedBox, findsOneWidget);
    });

    testWidgets('renders with special characters in title', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Title: @#\$%',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Title: @#\$%'), findsOneWidget);
    });

    testWidgets('renders with special characters in value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Title',
            value: 'Value: @#\$%^&*()',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Value: @#\$%^&*()'), findsOneWidget);
    });

    testWidgets('renders with numeric value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const KeyValueRowWidget(
            title: 'Count',
            value: '12345',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Count'), findsOneWidget);
      expect(find.text('12345'), findsOneWidget);
    });
  });
}
