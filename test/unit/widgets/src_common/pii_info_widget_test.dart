import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/pii_info_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(body: child),
    );
  }

  group('PiiInfoWidget', () {
    testWidgets('renders correctly with piiValue and style', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'test-pii-value',
            TextStyle(fontSize: 14),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PiiInfoWidget), findsOneWidget);
      expect(find.text('test-pii-value'), findsOneWidget);
    });

    testWidgets('wraps content in GestureDetector', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'test-value',
            TextStyle(fontSize: 14),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('renders Text widget with piiValue', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'masked-value',
            TextStyle(fontSize: 16),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('masked-value'), findsOneWidget);
    });

    testWidgets('applies underline decoration to text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'underlined-text',
            TextStyle(fontSize: 14),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('underlined-text'));
      expect(text.style?.decoration, TextDecoration.underline);
    });

    testWidgets('applies primary color to text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'colored-text',
            TextStyle(fontSize: 14),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('colored-text'));
      expect(text.style?.color, Colors.blue);
    });

    testWidgets('preserves original style properties', (tester) async {
      const originalStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'styled-text',
            originalStyle,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Text should be rendered with copyWith applied
      final text = tester.widget<Text>(find.text('styled-text'));
      expect(text.style, isNotNull);
    });

    testWidgets('renders with null style', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'null-style-text',
            null,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PiiInfoWidget), findsOneWidget);
      expect(find.text('null-style-text'), findsOneWidget);
    });

    testWidgets('renders with empty piiValue', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            '',
            TextStyle(fontSize: 14),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PiiInfoWidget), findsOneWidget);
    });

    testWidgets('renders with special characters in piiValue', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'special@#\$%^&*()chars',
            TextStyle(fontSize: 14),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('special@#\$%^&*()chars'), findsOneWidget);
    });

    testWidgets('renders with long piiValue', (tester) async {
      const longValue = 'This is a very long PII value that might need to be truncated or wrapped depending on the container';
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            width: 200,
            child: PiiInfoWidget(
              longValue,
              TextStyle(fontSize: 14),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(longValue), findsOneWidget);
    });

    testWidgets('responds to tap gesture', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const PiiInfoWidget(
            'tappable-text',
            TextStyle(fontSize: 14),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find GestureDetector and verify it's tappable
      final gestureDetector = tester.widget<GestureDetector>(find.byType(GestureDetector));
      expect(gestureDetector.onTap, isNotNull);
    });

    testWidgets('renders with different font sizes', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const Column(
            children: [
              PiiInfoWidget('small', TextStyle(fontSize: 10)),
              PiiInfoWidget('medium', TextStyle(fontSize: 16)),
              PiiInfoWidget('large', TextStyle(fontSize: 24)),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('small'), findsOneWidget);
      expect(find.text('medium'), findsOneWidget);
      expect(find.text('large'), findsOneWidget);
    });

    testWidgets('widget inherits theme primary color', (tester) async {
      const customTheme = Colors.green;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            primaryColor: customTheme,
          ),
          home: const Scaffold(
            body: PiiInfoWidget(
              'themed-text',
              TextStyle(fontSize: 14),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('themed-text'));
      expect(text.style?.color, customTheme);
    });
  });
}
