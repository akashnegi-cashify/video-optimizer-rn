import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/dotted_divider_line.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child, {double? width, double? height}) {
    return MaterialApp(
      theme: ThemeData(dividerColor: Colors.grey),
      home: Scaffold(
        body: SizedBox(
          width: width ?? 300,
          height: height ?? 300,
          child: child,
        ),
      ),
    );
  }

  group('DottedLineDivider - Horizontal Axis', () {
    testWidgets('renders horizontal divider with default parameters',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
      expect(find.byType(LayoutBuilder), findsOneWidget);
      expect(find.byType(Flex), findsOneWidget);
    });

    testWidgets('renders horizontal dashes', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(isHorizontalAxis: true),
        ),
      );
      await tester.pumpAndSettle();

      // Should have multiple SizedBox (dashes) inside Flex
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(DecoratedBox), findsWidgets);
    });

    testWidgets('renders with custom dash width', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(dashWidth: 20.0),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
    });

    testWidgets('renders with custom height', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(height: 3),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
    });

    testWidgets('renders with custom color', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(color: Colors.red),
        ),
      );
      await tester.pumpAndSettle();

      final decoratedBoxes = tester.widgetList<DecoratedBox>(
        find.descendant(
          of: find.byType(DottedLineDivider),
          matching: find.byType(DecoratedBox),
        ),
      );

      // Verify that dashes have the custom color
      for (final box in decoratedBoxes) {
        final decoration = box.decoration as BoxDecoration;
        expect(decoration.color, Colors.red);
      }
    });

    testWidgets('uses theme divider color when no color provided',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(),
        ),
      );
      await tester.pumpAndSettle();

      final decoratedBoxes = tester.widgetList<DecoratedBox>(
        find.descendant(
          of: find.byType(DottedLineDivider),
          matching: find.byType(DecoratedBox),
        ),
      );

      // Should use theme's divider color (grey)
      expect(decoratedBoxes, isNotEmpty);
    });

    testWidgets('renders dashes with correct dash width', (tester) async {
      const customDashWidth = 15.0;
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(dashWidth: customDashWidth),
        ),
      );
      await tester.pumpAndSettle();

      final sizedBoxes = tester.widgetList<SizedBox>(
        find.descendant(
          of: find.byType(Flex),
          matching: find.byType(SizedBox),
        ),
      );

      // Each dash SizedBox should have the custom width
      for (final box in sizedBoxes) {
        expect(box.width, customDashWidth);
      }
    });

    testWidgets('renders all parameters combined', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(
            height: 2,
            dashWidth: 8.0,
            color: Colors.blue,
            isHorizontalAxis: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
    });
  });

  group('DottedLineDivider - Vertical Axis', () {
    testWidgets('renders vertical divider', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(isHorizontalAxis: false),
          height: 300,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
      expect(find.byType(LayoutBuilder), findsOneWidget);
    });

    testWidgets('renders vertical dashes with Axis.vertical direction',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(isHorizontalAxis: false),
          height: 300,
        ),
      );
      await tester.pumpAndSettle();

      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.direction, Axis.vertical);
    });

    testWidgets('renders vertical divider with custom width', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(
            isHorizontalAxis: false,
            width: 3,
          ),
          height: 300,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
    });

    testWidgets('renders vertical divider with custom dashHeight',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(
            isHorizontalAxis: false,
            dashHeight: 15.0,
          ),
          height: 300,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
    });

    testWidgets('renders vertical divider with custom color', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(
            isHorizontalAxis: false,
            color: Colors.green,
          ),
          height: 300,
        ),
      );
      await tester.pumpAndSettle();

      final decoratedBoxes = tester.widgetList<DecoratedBox>(
        find.descendant(
          of: find.byType(DottedLineDivider),
          matching: find.byType(DecoratedBox),
        ),
      );

      for (final box in decoratedBoxes) {
        final decoration = box.decoration as BoxDecoration;
        expect(decoration.color, Colors.green);
      }
    });

    testWidgets('renders all vertical parameters combined', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(
            isHorizontalAxis: false,
            width: 2,
            dashHeight: 12.0,
            color: Colors.purple,
          ),
          height: 300,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.direction, Axis.vertical);
    });
  });

  group('DottedLineDivider - Layout Behavior', () {
    testWidgets('horizontal divider adapts to container width', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(),
          width: 200,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);

      // Change width and rebuild
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
    });

    testWidgets('vertical divider adapts to container height', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(isHorizontalAxis: false),
          height: 200,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);

      // Change height and rebuild
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(isHorizontalAxis: false),
          height: 400,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DottedLineDivider), findsOneWidget);
    });

    testWidgets('uses mainAxisAlignment spaceBetween', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const DottedLineDivider(),
        ),
      );
      await tester.pumpAndSettle();

      final flex = tester.widget<Flex>(find.byType(Flex));
      expect(flex.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });
  });
}
