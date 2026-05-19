import 'package:builder_project/builder_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_question_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_question_summary_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/models/audit_question_comp_param.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/models/audit_question_summary_comp_param.dart';

void main() {
  group('AuditQuestionsScreen', () {
    test('has correct pageKey', () {
      expect(AuditQuestionsScreen.pageKey, 'audit_questions');
    });

    test('has correct route', () {
      expect(AuditQuestionsScreen.route, '/audit_questions_screen');
    });

    test('can be instantiated', () {
      const screen = AuditQuestionsScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('test');
      const screen = AuditQuestionsScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('buildView method exists', () {
      const screen = AuditQuestionsScreen();
      expect(screen.buildView, isNotNull);
    });

    testWidgets('buildView returns PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          const screen = AuditQuestionsScreen();
          builtWidget = screen.buildView(context);
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<PageWidget>());
    });
  });

  group('AuditQuestionsScreenArguments', () {
    test('creates arguments with scannedBarcode', () {
      final args = AuditQuestionsScreenArguments(scannedBarcode: 'TEST_BARCODE_123');
      expect(args.scannedBarcode, 'TEST_BARCODE_123');
    });

    test('creates arguments with null scannedBarcode', () {
      final args = AuditQuestionsScreenArguments(scannedBarcode: null);
      expect(args.scannedBarcode, isNull);
    });

    test('creates arguments with default null', () {
      final args = AuditQuestionsScreenArguments();
      expect(args.scannedBarcode, isNull);
    });

    test('toJson returns correct map with scannedBarcode', () {
      final args = AuditQuestionsScreenArguments(scannedBarcode: 'BARCODE_456');
      final json = args.toJson();
      expect(json[AuditQuestionParamKeys.scannedBarcode.value], 'BARCODE_456');
    });

    test('toJson returns correct map with null scannedBarcode', () {
      final args = AuditQuestionsScreenArguments(scannedBarcode: null);
      final json = args.toJson();
      expect(json[AuditQuestionParamKeys.scannedBarcode.value], isNull);
    });

    test('toJson returns map with single key', () {
      final args = AuditQuestionsScreenArguments(scannedBarcode: 'TEST');
      final json = args.toJson();
      expect(json.length, 1);
      expect(json.containsKey(AuditQuestionParamKeys.scannedBarcode.value), isTrue);
    });

    test('multiple args instances are independent', () {
      final args1 = AuditQuestionsScreenArguments(scannedBarcode: 'BARCODE_1');
      final args2 = AuditQuestionsScreenArguments(scannedBarcode: 'BARCODE_2');
      expect(args1.scannedBarcode, isNot(args2.scannedBarcode));
    });
  });

  group('AuditQuestionSummaryScreen', () {
    test('has correct pageKey', () {
      expect(AuditQuestionSummaryScreen.pageKey, 'audit_question_summary');
    });

    test('has correct route', () {
      expect(AuditQuestionSummaryScreen.route, '/audit-question-summary-screen');
    });

    test('can be instantiated', () {
      const screen = AuditQuestionSummaryScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const key = Key('summary_test');
      const screen = AuditQuestionSummaryScreen(key: key);
      expect(screen.key, equals(key));
    });

    test('buildView method exists', () {
      const screen = AuditQuestionSummaryScreen();
      expect(screen.buildView, isNotNull);
    });

    testWidgets('buildView returns PageWidget', (tester) async {
      Widget? builtWidget;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          const screen = AuditQuestionSummaryScreen();
          builtWidget = screen.buildView(context);
          return const SizedBox();
        }),
      ));
      await tester.pump();
      expect(builtWidget, isA<PageWidget>());
    });
  });

  group('AuditQuestionSummaryArguments', () {
    test('creates arguments with all fields', () {
      final questionData = AuditQuestionResponse();
      final args = AuditQuestionSummaryArguments(
        scannedBarcode: 'SUMMARY_BARCODE',
        questionDataModel: questionData,
      );
      expect(args.scannedBarcode, 'SUMMARY_BARCODE');
      expect(args.questionDataModel, questionData);
    });

    test('creates arguments with null scannedBarcode', () {
      final questionData = AuditQuestionResponse();
      final args = AuditQuestionSummaryArguments(
        scannedBarcode: null,
        questionDataModel: questionData,
      );
      expect(args.scannedBarcode, isNull);
      expect(args.questionDataModel, questionData);
    });

    test('creates arguments with null questionDataModel', () {
      final args = AuditQuestionSummaryArguments(
        scannedBarcode: 'BARCODE',
        questionDataModel: null,
      );
      expect(args.scannedBarcode, 'BARCODE');
      expect(args.questionDataModel, isNull);
    });

    test('creates arguments with all nulls', () {
      final args = AuditQuestionSummaryArguments(
        scannedBarcode: null,
        questionDataModel: null,
      );
      expect(args.scannedBarcode, isNull);
      expect(args.questionDataModel, isNull);
    });

    test('creates arguments with default nulls', () {
      final args = AuditQuestionSummaryArguments();
      expect(args.scannedBarcode, isNull);
      expect(args.questionDataModel, isNull);
    });

    test('toJson returns correct map with scannedBarcode key', () {
      final args = AuditQuestionSummaryArguments(scannedBarcode: 'TEST_BC');
      final json = args.toJson();
      expect(json[AuditQuestionSummaryCompParamKeys.scannedBarcode.value], 'TEST_BC');
    });

    test('toJson returns correct map with questionDataModel key', () {
      final questionData = AuditQuestionResponse();
      final args = AuditQuestionSummaryArguments(questionDataModel: questionData);
      final json = args.toJson();
      expect(json[AuditQuestionSummaryCompParamKeys.questionDataModel.value], questionData);
    });

    test('toJson returns map with two keys', () {
      final questionData = AuditQuestionResponse();
      final args = AuditQuestionSummaryArguments(
        scannedBarcode: 'BC',
        questionDataModel: questionData,
      );
      final json = args.toJson();
      expect(json.length, 2);
      expect(json.containsKey(AuditQuestionSummaryCompParamKeys.scannedBarcode.value), isTrue);
      expect(json.containsKey(AuditQuestionSummaryCompParamKeys.questionDataModel.value), isTrue);
    });

    test('multiple args instances are independent', () {
      final questionData1 = AuditQuestionResponse();
      final questionData2 = AuditQuestionResponse();
      final args1 = AuditQuestionSummaryArguments(
        scannedBarcode: 'BC_1',
        questionDataModel: questionData1,
      );
      final args2 = AuditQuestionSummaryArguments(
        scannedBarcode: 'BC_2',
        questionDataModel: questionData2,
      );
      expect(args1.scannedBarcode, isNot(args2.scannedBarcode));
      expect(args1.questionDataModel, isNot(args2.questionDataModel));
    });
  });

  group('AuditQuestionParamKeys', () {
    test('scannedBarcode has correct value', () {
      expect(AuditQuestionParamKeys.scannedBarcode.value, 'sb');
    });

    test('contains only scannedBarcode', () {
      expect(AuditQuestionParamKeys.values.length, 1);
      expect(AuditQuestionParamKeys.values, contains(AuditQuestionParamKeys.scannedBarcode));
    });
  });

  group('AuditQuestionSummaryCompParamKeys', () {
    test('questionDataModel has correct value', () {
      expect(AuditQuestionSummaryCompParamKeys.questionDataModel.value, 'qdm');
    });

    test('scannedBarcode has correct value', () {
      expect(AuditQuestionSummaryCompParamKeys.scannedBarcode.value, 'sb');
    });

    test('contains both keys', () {
      expect(AuditQuestionSummaryCompParamKeys.values.length, 2);
      expect(AuditQuestionSummaryCompParamKeys.values, contains(AuditQuestionSummaryCompParamKeys.questionDataModel));
      expect(AuditQuestionSummaryCompParamKeys.values, contains(AuditQuestionSummaryCompParamKeys.scannedBarcode));
    });
  });

  group('AuditQuestionResponse', () {
    test('can be created with default constructor', () {
      final response = AuditQuestionResponse();
      expect(response, isNotNull);
      expect(response.auditQuestionList, isNull);
      expect(response.manualAuditQuestionList, isNull);
    });

    test('fromJson creates instance from empty map', () {
      final response = AuditQuestionResponse.fromJson({});
      expect(response, isNotNull);
      expect(response.auditQuestionList, isNull);
      expect(response.manualAuditQuestionList, isNull);
    });

    test('fromJson creates instance with auditQuestionList', () {
      final json = {
        'dpr': [
          {'pi': 1, 'pn': 'Question 1', 'v': {'1': 'Yes', '0': 'No'}}
        ],
      };
      final response = AuditQuestionResponse.fromJson(json);
      expect(response.auditQuestionList, isNotNull);
      expect(response.auditQuestionList!.length, 1);
      expect(response.auditQuestionList![0].questionId, 1);
      expect(response.auditQuestionList![0].question, 'Question 1');
    });

    test('fromJson creates instance with manualAuditQuestionList', () {
      final json = {
        'maq': [
          {'mmid': 101, 'q': 'Manual Question 1'},
        ],
      };
      final response = AuditQuestionResponse.fromJson(json);
      expect(response.manualAuditQuestionList, isNotNull);
      expect(response.manualAuditQuestionList!.length, 1);
      expect(response.manualAuditQuestionList![0].manualMasterId, 101);
      expect(response.manualAuditQuestionList![0].question, 'Manual Question 1');
    });

    test('toJson returns correct map', () {
      final response = AuditQuestionResponse();
      final json = response.toJson();
      expect(json, isA<Map<String, dynamic>>());
    });
  });

  group('AuditQuestionData', () {
    test('can be created with all parameters', () {
      final data = AuditQuestionData(
        1,
        'Test Question',
        {'1': 'Yes', '0': 'No'},
        selectedOption: '1',
        s3url: 'https://s3.example.com/image.jpg',
      );
      expect(data.questionId, 1);
      expect(data.question, 'Test Question');
      expect(data.options, {'1': 'Yes', '0': 'No'});
      expect(data.selectedOption, '1');
      expect(data.s3url, 'https://s3.example.com/image.jpg');
    });

    test('can be created with minimal parameters', () {
      final data = AuditQuestionData(2, 'Minimal Question', null);
      expect(data.questionId, 2);
      expect(data.question, 'Minimal Question');
      expect(data.options, isNull);
    });

    test('fromJson creates instance correctly', () {
      final json = {
        'pi': 10,
        'pn': 'JSON Question',
        'ic': 3,
        'v': {'1': 'Option A', '2': 'Option B'},
      };
      final data = AuditQuestionData.fromJson(json);
      expect(data.questionId, 10);
      expect(data.question, 'JSON Question');
      expect(data.imageCount, 3);
      expect(data.options, {'1': 'Option A', '2': 'Option B'});
    });

    test('fromJson handles string imageCount', () {
      final json = {
        'pi': 11,
        'pn': 'IC Test',
        'ic': '5',
        'v': {},
      };
      final data = AuditQuestionData.fromJson(json);
      expect(data.imageCount, 5);
    });

    test('fromJson handles subVariations', () {
      final json = {
        'pi': 12,
        'pn': 'SubVar Test',
        'v': {'1': 'Yes'},
        'subVariations': {
          '1': ['Sub A', 'Sub B'],
        },
      };
      final data = AuditQuestionData.fromJson(json);
      expect(data.subVariations, isNotNull);
      expect(data.subVariations!['1'], ['Sub A', 'Sub B']);
    });

    test('toJson returns correct map', () {
      final data = AuditQuestionData(
        20,
        'ToJson Test',
        {'1': 'Yes', '0': 'No'},
      );
      data.imageCount = 2;
      final json = data.toJson();
      expect(json['pi'], 20);
      expect(json['pn'], 'ToJson Test');
      expect(json['ic'], 2);
      expect(json['v'], {'1': 'Yes', '0': 'No'});
    });
  });

  group('ManualAuditQuestionItem', () {
    test('can be created with constructor', () {
      final item = ManualAuditQuestionItem(1, 'Manual Question');
      expect(item.manualMasterId, 1);
      expect(item.question, 'Manual Question');
    });

    test('fromJson creates instance correctly', () {
      final json = {'mmid': 100, 'q': 'From JSON'};
      final item = ManualAuditQuestionItem.fromJson(json);
      expect(item.manualMasterId, 100);
      expect(item.question, 'From JSON');
    });

    test('fromJson handles isSelected', () {
      final json = {'mmid': 101, 'q': 'Selected', 'is': true};
      final item = ManualAuditQuestionItem.fromJson(json);
      expect(item.isSelected, true);
    });

    test('toJson returns correct map', () {
      final item = ManualAuditQuestionItem(200, 'ToJson');
      item.isSelected = true;
      final json = item.toJson();
      expect(json['mmid'], 200);
      expect(json['q'], 'ToJson');
      expect(json['is'], true);
    });
  });

  group('AuditQuestionsScreen navigation', () {
    testWidgets('navigates with arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == AuditQuestionsScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Audit Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AuditQuestionsScreen.route,
                        arguments: AuditQuestionsScreenArguments(scannedBarcode: 'NAV_BARCODE'),
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

      expect(pushedRoute, AuditQuestionsScreen.route);
      expect(pushedArguments, isA<AuditQuestionsScreenArguments>());
      expect(
        (pushedArguments as AuditQuestionsScreenArguments).scannedBarcode,
        'NAV_BARCODE',
      );
    });

    testWidgets('navigates with null arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == AuditQuestionsScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Audit Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AuditQuestionsScreen.route,
                        arguments: AuditQuestionsScreenArguments(),
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

      expect(pushedRoute, AuditQuestionsScreen.route);
      expect(pushedArguments, isA<AuditQuestionsScreenArguments>());
      expect(
        (pushedArguments as AuditQuestionsScreenArguments).scannedBarcode,
        isNull,
      );
    });
  });

  group('AuditQuestionSummaryScreen navigation', () {
    testWidgets('navigates with arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;
      final questionData = AuditQuestionResponse();

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == AuditQuestionSummaryScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Summary Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AuditQuestionSummaryScreen.route,
                        arguments: AuditQuestionSummaryArguments(
                          scannedBarcode: 'SUMMARY_NAV_BC',
                          questionDataModel: questionData,
                        ),
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

      expect(pushedRoute, AuditQuestionSummaryScreen.route);
      expect(pushedArguments, isA<AuditQuestionSummaryArguments>());
      expect(
        (pushedArguments as AuditQuestionSummaryArguments).scannedBarcode,
        'SUMMARY_NAV_BC',
      );
      expect(
        (pushedArguments as AuditQuestionSummaryArguments).questionDataModel,
        questionData,
      );
    });

    testWidgets('navigates with null arguments', (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == AuditQuestionSummaryScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Summary Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AuditQuestionSummaryScreen.route,
                        arguments: AuditQuestionSummaryArguments(),
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

      expect(pushedRoute, AuditQuestionSummaryScreen.route);
      expect(pushedArguments, isA<AuditQuestionSummaryArguments>());
      expect(
        (pushedArguments as AuditQuestionSummaryArguments).scannedBarcode,
        isNull,
      );
      expect(
        (pushedArguments as AuditQuestionSummaryArguments).questionDataModel,
        isNull,
      );
    });
  });
}
