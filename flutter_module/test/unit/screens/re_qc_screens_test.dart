import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_list_screen.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_detail_screen.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';

void main() {
  group('ReQcListScreen', () {
    test('has correct pageKey', () {
      expect(ReQcListScreen.pageKey, 'QC_re_qc_list_screen');
    });

    test('has correct route', () {
      expect(ReQcListScreen.route, '/qc_re_qc_list_screen');
    });

    test('can be instantiated', () {
      const screen = ReQcListScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('test_key');
      const screen = ReQcListScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('ReQcDetailScreen', () {
    test('has correct pageKey', () {
      expect(ReQcDetailScreen.pageKey, 'QC_re_qc_detail_screen');
    });

    test('has correct route', () {
      expect(ReQcDetailScreen.route, '/re-qc/detail/');
    });

    test('can be instantiated', () {
      const screen = ReQcDetailScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('detail_test_key');
      const screen = ReQcDetailScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('ReQcDetailScreenArguments', () {
    test('creates arguments with reQcListData', () {
      final reQcListData = ReQcListData(
        lotGroupName: 'TEST_LOT_GROUP',
        lotCount: 10,
        lotId: 123,
        pendingCount: 5,
        doneCount: 3,
        auditCount: 2,
        lotType: 'LOB',
        skipReQc: false,
      );
      final args = ReQcDetailScreenArguments(reQcListData);
      expect(args.reQcListData, reQcListData);
      expect(args.reQcListData?.lotGroupName, 'TEST_LOT_GROUP');
      expect(args.reQcListData?.lotId, 123);
    });

    test('creates arguments with null reQcListData', () {
      final args = ReQcDetailScreenArguments(null);
      expect(args.reQcListData, isNull);
    });

    test('toJson returns correct map with reQcListData key', () {
      final reQcListData = ReQcListData(
        lotGroupName: 'TEST_LOT',
        lotId: 456,
      );
      final args = ReQcDetailScreenArguments(reQcListData);
      final json = args.toJson();
      expect(json['reQcListData'], reQcListData);
    });

    test('toJson returns correct map with null reQcListData', () {
      final args = ReQcDetailScreenArguments(null);
      final json = args.toJson();
      expect(json['reQcListData'], isNull);
    });

    test('toJson returns map with single key', () {
      final reQcListData = ReQcListData(lotGroupName: 'LOT_123');
      final args = ReQcDetailScreenArguments(reQcListData);
      final json = args.toJson();
      expect(json.length, 1);
      expect(json.containsKey('reQcListData'), isTrue);
    });

    test('reQcListData properties are stored correctly', () {
      final reQcListData = ReQcListData(
        lotGroupName: 'PROP_TEST',
        lotCount: 20,
        lotId: 789,
        pendingCount: 8,
        doneCount: 10,
        auditCount: 2,
        lotType: 'CDP',
        skipReQc: true,
      );
      final args = ReQcDetailScreenArguments(reQcListData);
      expect(args.reQcListData?.lotGroupName, 'PROP_TEST');
      expect(args.reQcListData?.lotCount, 20);
      expect(args.reQcListData?.lotId, 789);
      expect(args.reQcListData?.pendingCount, 8);
      expect(args.reQcListData?.doneCount, 10);
      expect(args.reQcListData?.auditCount, 2);
      expect(args.reQcListData?.lotType, 'CDP');
      expect(args.reQcListData?.skipReQc, true);
    });

    test('multiple args instances are independent', () {
      final reQcListData1 = ReQcListData(lotGroupName: 'LOT_1', lotId: 1);
      final reQcListData2 = ReQcListData(lotGroupName: 'LOT_2', lotId: 2);
      final args1 = ReQcDetailScreenArguments(reQcListData1);
      final args2 = ReQcDetailScreenArguments(reQcListData2);
      expect(args1.reQcListData?.lotGroupName, isNot(args2.reQcListData?.lotGroupName));
      expect(args1.reQcListData?.lotId, isNot(args2.reQcListData?.lotId));
    });
  });

  group('ReQcListData', () {
    test('can be created with all properties', () {
      final data = ReQcListData(
        lotGroupName: 'TEST_GROUP',
        lotCount: 100,
        lotId: 999,
        pendingCount: 50,
        doneCount: 40,
        auditCount: 10,
        lotType: 'LOB',
        skipReQc: false,
      );
      expect(data.lotGroupName, 'TEST_GROUP');
      expect(data.lotCount, 100);
      expect(data.lotId, 999);
      expect(data.pendingCount, 50);
      expect(data.doneCount, 40);
      expect(data.auditCount, 10);
      expect(data.lotType, 'LOB');
      expect(data.skipReQc, false);
    });

    test('can be created with minimal properties', () {
      final data = ReQcListData(lotGroupName: 'MINIMAL');
      expect(data.lotGroupName, 'MINIMAL');
      expect(data.lotCount, isNull);
      expect(data.lotId, isNull);
    });

    test('fromJson creates instance correctly', () {
      final json = {
        'lotGroupName': 'JSON_LOT',
        'lotCount': 25,
        'id': 111,
        'qcPending': 15,
        'qcDone': 8,
        'qcAudit': 2,
        'lotType': 'CDP',
        'skipReQc': true,
      };
      final data = ReQcListData.fromJson(json);
      expect(data.lotGroupName, 'JSON_LOT');
      expect(data.lotCount, 25);
      expect(data.lotId, 111);
      expect(data.pendingCount, 15);
      expect(data.doneCount, 8);
      expect(data.auditCount, 2);
      expect(data.lotType, 'CDP');
      expect(data.skipReQc, true);
    });

    test('toJson returns correct map', () {
      final data = ReQcListData(
        lotGroupName: 'TO_JSON_TEST',
        lotCount: 30,
        lotId: 222,
        pendingCount: 20,
        doneCount: 5,
        auditCount: 5,
        lotType: 'LOB',
        skipReQc: false,
      );
      final json = data.toJson();
      expect(json['lotGroupName'], 'TO_JSON_TEST');
      expect(json['lotCount'], 30);
      expect(json['id'], 222);
      expect(json['qcPending'], 20);
      expect(json['qcDone'], 5);
      expect(json['qcAudit'], 5);
      expect(json['lotType'], 'LOB');
      expect(json['skipReQc'], false);
    });
  });

  group('ReQcDetailScreen.navigateTo', () {
    testWidgets('navigateTo pushes named route', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;
      final reQcListData = ReQcListData(
        lotGroupName: 'NAV_TEST_LOT',
        lotId: 555,
      );

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == ReQcDetailScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Detail Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ReQcDetailScreen.route,
                        arguments: ReQcDetailScreenArguments(reQcListData),
                      );
                    },
                    child: const Text('Navigate'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      expect(pushedRoute, ReQcDetailScreen.route);
      expect(pushedArguments, isA<ReQcDetailScreenArguments>());
      expect(
        (pushedArguments as ReQcDetailScreenArguments).reQcListData?.lotGroupName,
        'NAV_TEST_LOT',
      );
      expect(
        (pushedArguments as ReQcDetailScreenArguments).reQcListData?.lotId,
        555,
      );
    });

    testWidgets('navigateTo pushes route with null data', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == ReQcDetailScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Detail Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ReQcDetailScreen.route,
                        arguments: ReQcDetailScreenArguments(null),
                      );
                    },
                    child: const Text('Navigate Null'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Null'));
      await tester.pumpAndSettle();

      expect(pushedRoute, ReQcDetailScreen.route);
      expect(pushedArguments, isA<ReQcDetailScreenArguments>());
      expect(
        (pushedArguments as ReQcDetailScreenArguments).reQcListData,
        isNull,
      );
    });
  });
}
