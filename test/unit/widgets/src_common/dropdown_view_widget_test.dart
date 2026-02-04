import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/dropdown_view_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('DropdownViewWidget', () {
    testWidgets('renders correctly with required value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(value: 'Test Value'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DropdownViewWidget), findsOneWidget);
      expect(find.text('Test Value'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        buildTestWidget(
          DropdownViewWidget(
            value: 'Test Value',
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find and tap the GestureDetector
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('renders with isDataSelected false (default)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(value: 'Test Value'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DropdownViewWidget), findsOneWidget);
      // Text should be displayed - color depends on theme
      expect(find.text('Test Value'), findsOneWidget);
    });

    testWidgets('renders with isDataSelected true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(
            value: 'Selected Value',
            isDataSelected: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DropdownViewWidget), findsOneWidget);
      expect(find.text('Selected Value'), findsOneWidget);
    });

    testWidgets('renders with null onPressed', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(
            value: 'No Press Handler',
            onPressed: null,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DropdownViewWidget), findsOneWidget);
      // Tapping should not throw
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();
    });

    testWidgets('truncates long text with ellipsis', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            width: 100,
            child: DropdownViewWidget(
              value: 'This is a very long text that should be truncated with ellipsis',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DropdownViewWidget), findsOneWidget);
      final text = tester.widget<Text>(find.byType(Text).first);
      expect(text.maxLines, 1);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets('renders Row with proper layout', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(value: 'Layout Test'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsWidgets);
      final row = tester.widget<Row>(find.descendant(
        of: find.byType(DropdownViewWidget),
        matching: find.byType(Row),
      ));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });

    testWidgets('renders Container with proper decoration', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(value: 'Decoration Test'),
        ),
      );
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(DropdownViewWidget),
        matching: find.byType(Container).first,
      ));
      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(Dimens.space_4));
    });

    testWidgets('renders CshIcon for arrow', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(value: 'Icon Test'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshIcon), findsOneWidget);
    });

    testWidgets('isDataSelected null defaults to false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(
            value: 'Test Value',
            isDataSelected: null,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DropdownViewWidget), findsOneWidget);
    });

    testWidgets('renders Expanded widget for text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DropdownViewWidget(value: 'Expanded Test'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Expanded), findsOneWidget);
    });
  });
}
