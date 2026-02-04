import 'package:builder_project/builder_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_video_screen.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('D2CVideoScreen', () {
    group('constants', () {
      test('has correct pageKey', () {
        expect(D2CVideoScreen.pageKey, 'QC_d2c_video_page_key');
      });

      test('has correct route', () {
        expect(D2CVideoScreen.route, '/qc/d2c-video');
      });
    });

    group('D2CVideoArguments', () {
      test('can be instantiated with barcode', () {
        final args = D2CVideoArguments('TEST_BARCODE');
        expect(args.barcode, 'TEST_BARCODE');
      });

      test('can be instantiated with null barcode', () {
        final args = D2CVideoArguments(null);
        expect(args.barcode, isNull);
      });

      test('has correct pageKey from BaseArguments', () {
        final args = D2CVideoArguments('TEST_BARCODE');
        expect(args.pageKey, D2CVideoScreen.pageKey);
      });

      test('toJson returns correct map with dbr key', () {
        final args = D2CVideoArguments('TEST_BARCODE');
        final json = args.toJson();
        // DeviceBarcodeParamKeys.deviceBarcode.value is 'dbr'
        expect(json['dbr'], 'TEST_BARCODE');
      });

      test('toJson with null barcode returns null value', () {
        final args = D2CVideoArguments(null);
        final json = args.toJson();
        expect(json['dbr'], isNull);
      });

      test('toJson returns map with dbr key', () {
        final args = D2CVideoArguments('BARCODE_123');
        final json = args.toJson();
        expect(json.containsKey('dbr'), isTrue);
        expect(json.length, equals(1));
      });

      test('handles special characters in barcode', () {
        final args = D2CVideoArguments('TEST-BARCODE_001/ABC');
        final json = args.toJson();
        expect(json['dbr'], 'TEST-BARCODE_001/ABC');
      });

      test('handles empty barcode', () {
        final args = D2CVideoArguments('');
        expect(args.barcode, '');
        final json = args.toJson();
        expect(json['dbr'], '');
      });
    });

    group('widget', () {
      test('D2CVideoScreen class exists', () {
        expect(D2CVideoScreen, isNotNull);
      });

      test('D2CVideoScreen can be instantiated', () {
        const screen = D2CVideoScreen();
        expect(screen, isNotNull);
      });

      test('D2CVideoScreen can be instantiated with key', () {
        const key = Key('d2c_video_screen');
        const screen = D2CVideoScreen(key: key);
        expect(screen.key, equals(key));
      });
    });

    group('navigation methods', () {
      test('navigate method exists', () {
        expect(D2CVideoScreen.navigate, isNotNull);
      });

      test('replace method exists', () {
        expect(D2CVideoScreen.replace, isNotNull);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const screen = D2CVideoScreen();
        expect(screen.buildView, isNotNull);
      });

      testWidgets('buildView returns PageWidget', (tester) async {
        Widget? builtWidget;

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: RouteSettings(
                  arguments: D2CVideoArguments('TEST_BARCODE'),
                ),
                builder: (context) {
                  const screen = D2CVideoScreen();
                  builtWidget = screen.buildView(context);
                  return const SizedBox(); // Return placeholder
                },
              );
            },
            initialRoute: '/',
          ),
        );

        await tester.pump();
        expect(builtWidget, isA<PageWidget>());
      });

      testWidgets('PageWidget has correct pageKey', (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: RouteSettings(
                  arguments: D2CVideoArguments('TEST_BARCODE'),
                ),
                builder: (context) {
                  const screen = D2CVideoScreen();
                  final widget = screen.buildView(context);
                  capturedWidget = widget is PageWidget ? widget : null;
                  return const SizedBox();
                },
              );
            },
            initialRoute: '/',
          ),
        );

        await tester.pump();
        expect(capturedWidget, isNotNull);
        expect(capturedWidget!.pageKey, equals(D2CVideoScreen.pageKey));
      });

      testWidgets('PageWidget receives initialValue from arguments',
          (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: RouteSettings(
                  arguments: D2CVideoArguments('BARCODE_123'),
                ),
                builder: (context) {
                  const screen = D2CVideoScreen();
                  final widget = screen.buildView(context);
                  capturedWidget = widget is PageWidget ? widget : null;
                  return const SizedBox();
                },
              );
            },
            initialRoute: '/',
          ),
        );

        await tester.pump();
        expect(capturedWidget, isNotNull);
        expect(capturedWidget!.initialValue, isNotNull);
        // DeviceBarcodeParamKeys.deviceBarcode.value is 'dbr'
        expect(capturedWidget!.initialValue!['dbr'], 'BARCODE_123');
      });

      testWidgets('handles null arguments gracefully', (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: const RouteSettings(arguments: null),
                builder: (context) {
                  const screen = D2CVideoScreen();
                  final widget = screen.buildView(context);
                  capturedWidget = widget is PageWidget ? widget : null;
                  return const SizedBox();
                },
              );
            },
            initialRoute: '/',
          ),
        );

        await tester.pump();
        expect(capturedWidget, isNotNull);
        expect(capturedWidget!.pageKey, equals(D2CVideoScreen.pageKey));
        expect(capturedWidget!.initialValue, isNull);
      });
    });

    group('static navigation', () {
      late MockNavigatorObserver mockNavigatorObserver;

      setUp(() {
        mockNavigatorObserver = MockNavigatorObserver();
        registerFallbackValue(
          MaterialPageRoute<dynamic>(builder: (_) => const SizedBox()),
        );
      });

      testWidgets('navigate pushes route with arguments', (tester) async {
        D2CVideoArguments? capturedArguments;

        await tester.pumpWidget(
          MaterialApp(
            navigatorObservers: [mockNavigatorObserver],
            routes: {
              D2CVideoScreen.route: (context) {
                capturedArguments = ModalRoute.of(context)?.settings.arguments
                    as D2CVideoArguments?;
                return const Scaffold(body: Text('D2C Video Screen'));
              },
            },
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () =>
                    D2CVideoScreen.navigate(context, 'TEST_BARCODE'),
                child: const Text('Navigate'),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(capturedArguments, isNotNull);
        expect(capturedArguments!.barcode, 'TEST_BARCODE');
      });

      testWidgets('replace pushes replacement route', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            navigatorObservers: [mockNavigatorObserver],
            routes: {
              D2CVideoScreen.route: (context) =>
                  const Scaffold(body: Text('D2C Video Screen')),
            },
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () =>
                    D2CVideoScreen.replace(context, 'TEST_BARCODE'),
                child: const Text('Replace'),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(() => mockNavigatorObserver.didReplace(
              newRoute: any(named: 'newRoute'),
              oldRoute: any(named: 'oldRoute'),
            )).called(1);
      });

      testWidgets('navigate with null barcode', (tester) async {
        D2CVideoArguments? capturedArguments;

        await tester.pumpWidget(
          MaterialApp(
            routes: {
              D2CVideoScreen.route: (context) {
                capturedArguments = ModalRoute.of(context)?.settings.arguments
                    as D2CVideoArguments?;
                return const Scaffold(body: Text('D2C Video Screen'));
              },
            },
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => D2CVideoScreen.navigate(context, null),
                child: const Text('Navigate'),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(capturedArguments, isNotNull);
        expect(capturedArguments!.barcode, isNull);
      });
    });
  });
}
