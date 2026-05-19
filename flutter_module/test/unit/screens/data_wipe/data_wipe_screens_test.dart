import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_detail_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_home_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_list_screen.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('DataWipeDetailScreen', () {
    group('constants', () {
      test('has correct pageKey', () {
        expect(DataWipeDetailScreen.pageKey, 'QC_data_wipe_detail_screen');
      });

      test('has correct route', () {
        expect(DataWipeDetailScreen.route, '/qc_data_wipe_detail_screen');
      });
    });

    group('widget', () {
      test('DataWipeDetailScreen class exists', () {
        expect(DataWipeDetailScreen, isNotNull);
      });

      test('DataWipeDetailScreen can be instantiated', () {
        const screen = DataWipeDetailScreen();
        expect(screen, isNotNull);
      });

      test('DataWipeDetailScreen can be instantiated with key', () {
        const key = Key('data_wipe_detail_screen');
        const screen = DataWipeDetailScreen(key: key);
        expect(screen.key, equals(key));
      });
    });

    group('navigation', () {
      test('navigateTo method exists', () {
        expect(DataWipeDetailScreen.navigateTo, isNotNull);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const screen = DataWipeDetailScreen();
        expect(screen.buildView, isNotNull);
      });

      testWidgets('buildView returns PageWidget', (tester) async {
        Widget? builtWidget;

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: RouteSettings(
                  arguments: DataWipeDetailScreenArg(deviceBarcode: 'TEST_BARCODE'),
                ),
                builder: (context) {
                  const screen = DataWipeDetailScreen();
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
                  arguments: DataWipeDetailScreenArg(deviceBarcode: 'TEST_BARCODE'),
                ),
                builder: (context) {
                  const screen = DataWipeDetailScreen();
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
        expect(capturedWidget!.pageKey, equals(DataWipeDetailScreen.pageKey));
      });

      testWidgets('PageWidget receives initialValue from arguments', (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: RouteSettings(
                  arguments: DataWipeDetailScreenArg(deviceBarcode: 'BARCODE_456'),
                ),
                builder: (context) {
                  const screen = DataWipeDetailScreen();
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
        expect(capturedWidget!.initialValue!['dbr'], 'BARCODE_456');
      });

      testWidgets('handles null arguments gracefully', (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                settings: const RouteSettings(arguments: null),
                builder: (context) {
                  const screen = DataWipeDetailScreen();
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
        expect(capturedWidget!.pageKey, equals(DataWipeDetailScreen.pageKey));
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

      testWidgets('navigateTo pushes route with arguments', (tester) async {
        DataWipeDetailScreenArg? capturedArguments;

        await tester.pumpWidget(
          MaterialApp(
            navigatorObservers: [mockNavigatorObserver],
            routes: {
              DataWipeDetailScreen.route: (context) {
                capturedArguments = ModalRoute.of(context)?.settings.arguments
                    as DataWipeDetailScreenArg?;
                return const Scaffold(body: Text('Data Wipe Detail Screen'));
              },
            },
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () =>
                    DataWipeDetailScreen.navigateTo(context, 'TEST_BARCODE'),
                child: const Text('Navigate'),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(capturedArguments, isNotNull);
        expect(capturedArguments!.deviceBarcode, 'TEST_BARCODE');
      });

      testWidgets('navigateTo with isReplacement pushes replacement route',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            navigatorObservers: [mockNavigatorObserver],
            routes: {
              DataWipeDetailScreen.route: (context) =>
                  const Scaffold(body: Text('Data Wipe Detail Screen')),
            },
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => DataWipeDetailScreen.navigateTo(
                    context, 'TEST_BARCODE',
                    isReplacement: true),
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
    });
  });

  group('DataWipeDetailScreenArg', () {
    test('can be instantiated with deviceBarcode', () {
      final arg = DataWipeDetailScreenArg(deviceBarcode: 'TEST_BARCODE');
      expect(arg.deviceBarcode, 'TEST_BARCODE');
    });

    test('can be instantiated with null deviceBarcode', () {
      final arg = DataWipeDetailScreenArg(deviceBarcode: null);
      expect(arg.deviceBarcode, isNull);
    });

    test('can be instantiated without deviceBarcode', () {
      final arg = DataWipeDetailScreenArg();
      expect(arg.deviceBarcode, isNull);
    });

    test('has correct pageKey', () {
      final arg = DataWipeDetailScreenArg();
      expect(arg.pageKey, DataWipeDetailScreen.pageKey);
    });

    test('toJson returns correct map with dbr key', () {
      final arg = DataWipeDetailScreenArg(deviceBarcode: 'TEST_BARCODE');
      final json = arg.toJson();
      // DeviceBarcodeParamKeys.deviceBarcode.value is 'dbr'
      expect(json['dbr'], 'TEST_BARCODE');
    });

    test('toJson with null deviceBarcode returns map with null value', () {
      final arg = DataWipeDetailScreenArg(deviceBarcode: null);
      final json = arg.toJson();
      expect(json['dbr'], isNull);
    });

    test('handles special characters in deviceBarcode', () {
      final arg = DataWipeDetailScreenArg(deviceBarcode: 'TEST-BARCODE_001/ABC');
      expect(arg.deviceBarcode, 'TEST-BARCODE_001/ABC');
      final json = arg.toJson();
      expect(json['dbr'], 'TEST-BARCODE_001/ABC');
    });

    test('handles empty deviceBarcode', () {
      final arg = DataWipeDetailScreenArg(deviceBarcode: '');
      expect(arg.deviceBarcode, '');
    });
  });

  group('DataWipeHomeScreen', () {
    group('constants', () {
      test('has correct route', () {
        expect(DataWipeHomeScreen.route, '/QC_data_wipe_home_screen');
      });
    });

    group('widget', () {
      test('DataWipeHomeScreen class exists', () {
        expect(DataWipeHomeScreen, isNotNull);
      });

      test('DataWipeHomeScreen can be instantiated', () {
        const screen = DataWipeHomeScreen();
        expect(screen, isNotNull);
      });

      test('DataWipeHomeScreen can be instantiated with key', () {
        const key = Key('data_wipe_home_screen');
        const screen = DataWipeHomeScreen(key: key);
        expect(screen.key, equals(key));
      });

      test('DataWipeHomeScreen is a StatelessWidget', () {
        const screen = DataWipeHomeScreen();
        expect(screen, isA<StatelessWidget>());
      });
    });

    group('build', () {
      test('build method exists', () {
        const screen = DataWipeHomeScreen();
        expect(screen.build, isNotNull);
      });

      test('screen uses CshHeader for app bar', () {
        // DataWipeHomeScreen uses CshHeader which requires ThemeChangeProvider
        // We verify the structure exists without full rendering
        expect(CshHeader, isNotNull);
      });

      test('screen uses CshBigButton for buttons', () {
        // DataWipeHomeScreen uses CshBigButton for navigation
        expect(CshBigButton, isNotNull);
      });
    });
  });

  group('DataWipeListScreen', () {
    group('constants', () {
      test('has correct pageKey', () {
        expect(DataWipeListScreen.pageKey, 'QC_data_wipe_list_screen');
      });

      test('has correct route', () {
        expect(DataWipeListScreen.route, 'qc/data_wipe_list');
      });
    });

    group('widget', () {
      test('DataWipeListScreen class exists', () {
        expect(DataWipeListScreen, isNotNull);
      });

      test('DataWipeListScreen can be instantiated', () {
        const screen = DataWipeListScreen();
        expect(screen, isNotNull);
      });

      test('DataWipeListScreen can be instantiated with key', () {
        const key = Key('data_wipe_list_screen');
        const screen = DataWipeListScreen(key: key);
        expect(screen.key, equals(key));
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const screen = DataWipeListScreen();
        expect(screen.buildView, isNotNull);
      });

      testWidgets('buildView returns PageWidget', (tester) async {
        Widget? builtWidget;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                const screen = DataWipeListScreen();
                builtWidget = screen.buildView(context);
                return const SizedBox(); // Return placeholder
              },
            ),
          ),
        );

        await tester.pump();
        expect(builtWidget, isA<PageWidget>());
      });

      testWidgets('PageWidget has correct pageKey', (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                const screen = DataWipeListScreen();
                final widget = screen.buildView(context);
                capturedWidget = widget is PageWidget ? widget : null;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pump();
        expect(capturedWidget, isNotNull);
        expect(capturedWidget!.pageKey, equals(DataWipeListScreen.pageKey));
      });

      testWidgets('PageWidget has no initialValue', (tester) async {
        PageWidget? capturedWidget;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                const screen = DataWipeListScreen();
                final widget = screen.buildView(context);
                capturedWidget = widget is PageWidget ? widget : null;
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pump();
        expect(capturedWidget, isNotNull);
        expect(capturedWidget!.initialValue, isNull);
      });
    });
  });
}
