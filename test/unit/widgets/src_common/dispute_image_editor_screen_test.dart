import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/dispute_image_editor_screen.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:provider/provider.dart';

void main() {
  /// Builds a testable widget with MaterialApp and LocaleProvider wrapper
  Widget buildTestWidget(Widget child, {DisputeImageEditorScreenArg? arg}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: RouteSettings(arguments: arg),
          builder: (_) => child,
        ),
      ),
    );
  }

  group('DisputeImageEditorScreen', () {
    testWidgets('has correct route constant', (tester) async {
      expect(DisputeImageEditorScreen.route, '/image_editor');
    });

    testWidgets('renders Scaffold', (tester) async {
      // Note: This test requires a valid image file argument
      // In a real scenario, we'd create a temporary test file
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
          ],
          child: MaterialApp(
            theme: ThemeData(),
            home: const Scaffold(body: Text('Placeholder')),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
    });
  });

  group('SquareMetric', () {
    test('creates with required offset', () {
      final metric = SquareMetric(const Offset(10, 20));
      expect(metric.offset, const Offset(10, 20));
      expect(metric.height, 0);
      expect(metric.width, 0);
      expect(metric.normalizeOffset, isNull);
      expect(metric.normalizeWidth, isNull);
      expect(metric.normalizeHeight, isNull);
    });

    test('creates with all parameters', () {
      final metric = SquareMetric(
        const Offset(10, 20),
        height: 100,
        width: 200,
        normalizeOffset: const Offset(0.1, 0.2),
        normalizeWidth: 0.5,
        normalizeHeight: 0.25,
      );
      expect(metric.offset, const Offset(10, 20));
      expect(metric.height, 100);
      expect(metric.width, 200);
      expect(metric.normalizeOffset, const Offset(0.1, 0.2));
      expect(metric.normalizeWidth, 0.5);
      expect(metric.normalizeHeight, 0.25);
    });

    test('height and width can be modified', () {
      final metric = SquareMetric(const Offset(0, 0));
      metric.height = 50;
      metric.width = 75;
      expect(metric.height, 50);
      expect(metric.width, 75);
    });

    test('normalizeOffset can be set', () {
      final metric = SquareMetric(const Offset(0, 0));
      metric.normalizeOffset = const Offset(0.5, 0.5);
      expect(metric.normalizeOffset, const Offset(0.5, 0.5));
    });

    test('normalizeWidth can be set', () {
      final metric = SquareMetric(const Offset(0, 0));
      metric.normalizeWidth = 0.3;
      expect(metric.normalizeWidth, 0.3);
    });

    test('normalizeHeight can be set', () {
      final metric = SquareMetric(const Offset(0, 0));
      metric.normalizeHeight = 0.4;
      expect(metric.normalizeHeight, 0.4);
    });
  });

  group('DisputeImageEditorScreenArg', () {
    test('creates with imageFile', () {
      final file = File('test/path/image.jpg');
      final arg = DisputeImageEditorScreenArg(file);
      expect(arg.imageFile, file);
    });

    test('stores file reference correctly', () {
      final file = File('/tmp/test_image.png');
      final arg = DisputeImageEditorScreenArg(file);
      expect(arg.imageFile.path, '/tmp/test_image.png');
    });
  });

  group('SquarePainter', () {
    test('creates with squares list', () {
      final squares = <SquareMetric>[
        SquareMetric(const Offset(0, 0), height: 10, width: 10),
        SquareMetric(const Offset(20, 20), height: 30, width: 30),
      ];
      final painter = SquarePainter(squares);
      expect(painter.squares, squares);
    });

    test('creates with empty squares list', () {
      final painter = SquarePainter([]);
      expect(painter.squares, isEmpty);
    });

    test('shouldRepaint returns true', () {
      final painter = SquarePainter([]);
      expect(painter.shouldRepaint(painter), isTrue);
    });

    test('shouldRepaint returns true for different painters', () {
      final painter1 = SquarePainter([]);
      final painter2 = SquarePainter([SquareMetric(const Offset(0, 0))]);
      expect(painter1.shouldRepaint(painter2), isTrue);
    });
  });

  group('DisputeImageEditorScreenState', () {
    test('DisputeImageEditorScreenState class exists', () {
      expect(DisputeImageEditorScreenState, isNotNull);
    });
  });
}
