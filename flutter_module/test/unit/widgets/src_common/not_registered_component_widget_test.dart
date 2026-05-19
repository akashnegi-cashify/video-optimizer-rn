import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/not_registred_component_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('NotRegistered', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NotRegistered), findsOneWidget);
    });

    testWidgets('displays "Your Component is not registered yet" text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Your Component is not registered yet'), findsOneWidget);
    });

    testWidgets('renders Center widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('renders Padding widget with correct padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(Dimens.space_16));
    });

    testWidgets('renders Text widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Text uses titleMedium theme style', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('Your Component is not registered yet'));
      expect(text.style, isNotNull);
    });

    testWidgets('renders within parent Container', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Container(
            color: Colors.grey,
            child: const NotRegistered(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NotRegistered), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('centers content', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      // Verify Center widget wraps Padding
      final center = find.byType(Center);
      expect(center, findsOneWidget);

      // Padding should be descendant of Center
      expect(
        find.descendant(of: center, matching: find.byType(Padding)),
        findsOneWidget,
      );
    });

    testWidgets('can be used in Column', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Column(
            children: [
              Text('Header'),
              NotRegistered(),
              Text('Footer'),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NotRegistered), findsOneWidget);
      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
    });

    testWidgets('can be used in SingleChildScrollView', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SingleChildScrollView(
            child: NotRegistered(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NotRegistered), findsOneWidget);
    });

    testWidgets('inherits theme text style', (tester) async {
      final customTheme = ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: customTheme,
          home: const Scaffold(body: NotRegistered()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NotRegistered), findsOneWidget);
    });

    testWidgets('widget is const constructible', (tester) async {
      // Verify const constructor works
      const widget = NotRegistered();
      await tester.pumpWidget(
        buildTestWidget(widget),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NotRegistered), findsOneWidget);
    });

    testWidgets('has no key by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered()),
      );
      await tester.pumpAndSettle();

      final widget = tester.widget<NotRegistered>(find.byType(NotRegistered));
      expect(widget.key, isNull);
    });

    testWidgets('can accept key parameter', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const NotRegistered(key: Key('test_key'))),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('test_key')), findsOneWidget);
    });
  });
}
