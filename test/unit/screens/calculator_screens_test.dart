import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculator_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/submit_device_quote_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/disputed_questions_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';

void main() {
  group('CalculatorScannerScreen', () {
    test('has correct pageKey', () {
      expect(CalculatorScannerScreen.pageKey, 'QC_calculator_scanner_screen');
    });

    test('has correct route', () {
      expect(CalculatorScannerScreen.route, '/calculator_scanner');
    });

    test('can be instantiated', () {
      const screen = CalculatorScannerScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('scanner_test_key');
      const screen = CalculatorScannerScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('CalculationScreen', () {
    test('has correct pageKey', () {
      expect(CalculationScreen.pageKey, 'calculation_screen');
    });

    test('has correct route', () {
      expect(CalculationScreen.route, '/calculator-screen');
    });

    test('can be instantiated', () {
      const screen = CalculationScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('calculation_test_key');
      const screen = CalculationScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('SubmitDeviceQuoteScreen', () {
    test('has correct pageKey', () {
      expect(SubmitDeviceQuoteScreen.pageKey, 'QC_submit_device_quote_screen');
    });

    test('has correct route', () {
      expect(SubmitDeviceQuoteScreen.route, '/submit_device_quote');
    });

    test('can be instantiated', () {
      const screen = SubmitDeviceQuoteScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('submit_quote_test_key');
      const screen = SubmitDeviceQuoteScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DisputedQuestionScreen', () {
    test('has correct pageKey', () {
      expect(DisputedQuestionScreen.pageKey, 'disputed_questions');
    });

    test('has correct route', () {
      expect(DisputedQuestionScreen.route, '/disputed-question');
    });

    test('can be instantiated', () {
      const screen = DisputedQuestionScreen();
      expect(screen, isNotNull);
    });

    test('can be instantiated with key', () {
      const testKey = Key('disputed_test_key');
      const screen = DisputedQuestionScreen(key: testKey);
      expect(screen.key, testKey);
    });
  });

  group('DisputedQuestionsScreenArguments', () {
    test('creates arguments with disputedQuestionList', () {
      final questionList = [
        ManualAuditQuestionItem(1, 'Is the screen cracked?'),
        ManualAuditQuestionItem(2, 'Is the battery working?'),
      ];
      final args = DisputedQuestionsScreenArguments(
        disputedQuestionList: questionList,
      );
      expect(args.disputedQuestionList, questionList);
      expect(args.disputedQuestionList?.length, 2);
    });

    test('creates arguments with null disputedQuestionList', () {
      final args = DisputedQuestionsScreenArguments(disputedQuestionList: null);
      expect(args.disputedQuestionList, isNull);
    });

    test('creates arguments with empty disputedQuestionList', () {
      final args = DisputedQuestionsScreenArguments(disputedQuestionList: []);
      expect(args.disputedQuestionList, isEmpty);
    });

    test('toJson returns correct map with dql key', () {
      final questionList = [
        ManualAuditQuestionItem(1, 'Test question?'),
      ];
      final args = DisputedQuestionsScreenArguments(
        disputedQuestionList: questionList,
      );
      final json = args.toJson();
      // The key is 'dql' (DisputedQuestionParamKeys.disputedQuestionList.value)
      expect(json['dql'], questionList);
    });

    test('toJson returns correct map with null disputedQuestionList', () {
      final args = DisputedQuestionsScreenArguments(disputedQuestionList: null);
      final json = args.toJson();
      expect(json['dql'], isNull);
    });

    test('toJson returns map with single key', () {
      final questionList = [
        ManualAuditQuestionItem(1, 'Question 1'),
        ManualAuditQuestionItem(2, 'Question 2'),
      ];
      final args = DisputedQuestionsScreenArguments(
        disputedQuestionList: questionList,
      );
      final json = args.toJson();
      expect(json.length, 1);
      expect(json.containsKey('dql'), isTrue);
    });

    test('disputedQuestionList properties are stored correctly', () {
      final question1 = ManualAuditQuestionItem(101, 'Is touch working?');
      final question2 = ManualAuditQuestionItem(102, 'Is speaker working?');
      final questionList = [question1, question2];
      final args = DisputedQuestionsScreenArguments(
        disputedQuestionList: questionList,
      );
      expect(args.disputedQuestionList?[0].manualMasterId, 101);
      expect(args.disputedQuestionList?[0].question, 'Is touch working?');
      expect(args.disputedQuestionList?[1].manualMasterId, 102);
      expect(args.disputedQuestionList?[1].question, 'Is speaker working?');
    });

    test('multiple args instances are independent', () {
      final questionList1 = [ManualAuditQuestionItem(1, 'Question A')];
      final questionList2 = [ManualAuditQuestionItem(2, 'Question B')];
      final args1 = DisputedQuestionsScreenArguments(
        disputedQuestionList: questionList1,
      );
      final args2 = DisputedQuestionsScreenArguments(
        disputedQuestionList: questionList2,
      );
      expect(
        args1.disputedQuestionList?[0].manualMasterId,
        isNot(args2.disputedQuestionList?[0].manualMasterId),
      );
      expect(
        args1.disputedQuestionList?[0].question,
        isNot(args2.disputedQuestionList?[0].question),
      );
    });
  });

  group('ManualAuditQuestionItem', () {
    test('can be created with manualMasterId and question', () {
      final item = ManualAuditQuestionItem(123, 'Is the device working?');
      expect(item.manualMasterId, 123);
      expect(item.question, 'Is the device working?');
    });

    test('isSelected is null by default', () {
      final item = ManualAuditQuestionItem(1, 'Test');
      expect(item.isSelected, isNull);
    });

    test('isSelected can be set', () {
      final item = ManualAuditQuestionItem(1, 'Test');
      item.isSelected = true;
      expect(item.isSelected, true);
      item.isSelected = false;
      expect(item.isSelected, false);
    });

    test('fromJson creates instance correctly', () {
      final json = {
        'mmid': 456,
        'q': 'Is the screen damaged?',
      };
      final item = ManualAuditQuestionItem.fromJson(json);
      expect(item.manualMasterId, 456);
      expect(item.question, 'Is the screen damaged?');
    });

    test('toJson returns correct map', () {
      final item = ManualAuditQuestionItem(789, 'Is camera working?');
      final json = item.toJson();
      expect(json['mmid'], 789);
      expect(json['q'], 'Is camera working?');
    });

    test('toJson does not include isSelected field', () {
      final item = ManualAuditQuestionItem(1, 'Test');
      item.isSelected = true;
      final json = item.toJson();
      expect(json.containsKey('isSelected'), isFalse);
    });
  });

  group('DisputedQuestionScreen.pushNamed', () {
    testWidgets('pushNamed pushes route with arguments',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;
      final questionList = [
        ManualAuditQuestionItem(1, 'Test question 1'),
        ManualAuditQuestionItem(2, 'Test question 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == DisputedQuestionScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Disputed Questions Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DisputedQuestionScreen.pushNamed(
                        context,
                        disputedQuestionList: questionList,
                        onComplete: (manualQuestions) {},
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

      expect(pushedRoute, DisputedQuestionScreen.route);
      expect(pushedArguments, isA<DisputedQuestionsScreenArguments>());
      expect(
        (pushedArguments as DisputedQuestionsScreenArguments)
            .disputedQuestionList
            ?.length,
        2,
      );
    });

    testWidgets('pushNamed pushes route with null questionList',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == DisputedQuestionScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Disputed Questions Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DisputedQuestionScreen.pushNamed(
                        context,
                        disputedQuestionList: null,
                        onComplete: (manualQuestions) {},
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

      expect(pushedRoute, DisputedQuestionScreen.route);
      expect(pushedArguments, isA<DisputedQuestionsScreenArguments>());
      expect(
        (pushedArguments as DisputedQuestionsScreenArguments)
            .disputedQuestionList,
        isNull,
      );
    });

    testWidgets('pushNamed pushes route with empty questionList',
        (WidgetTester tester) async {
      String? pushedRoute;
      Object? pushedArguments;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == DisputedQuestionScreen.route) {
              pushedRoute = settings.name;
              pushedArguments = settings.arguments;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Disputed Questions Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      DisputedQuestionScreen.pushNamed(
                        context,
                        disputedQuestionList: [],
                        onComplete: (manualQuestions) {},
                      );
                    },
                    child: const Text('Navigate Empty'),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Navigate Empty'));
      await tester.pumpAndSettle();

      expect(pushedRoute, DisputedQuestionScreen.route);
      expect(pushedArguments, isA<DisputedQuestionsScreenArguments>());
      expect(
        (pushedArguments as DisputedQuestionsScreenArguments)
            .disputedQuestionList,
        isEmpty,
      );
    });
  });

  group('Calculator navigation routes', () {
    testWidgets('CalculatorScannerScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == CalculatorScannerScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Scanner Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CalculatorScannerScreen.route);
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

      expect(pushedRoute, CalculatorScannerScreen.route);
    });

    testWidgets('CalculationScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == CalculationScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) => const Scaffold(body: Text('Calculation Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CalculationScreen.route);
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

      expect(pushedRoute, CalculationScreen.route);
    });

    testWidgets('SubmitDeviceQuoteScreen route can be pushed',
        (WidgetTester tester) async {
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == SubmitDeviceQuoteScreen.route) {
              pushedRoute = settings.name;
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Text('Submit Device Quote Screen')),
              );
            }
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SubmitDeviceQuoteScreen.route);
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

      expect(pushedRoute, SubmitDeviceQuoteScreen.route);
    });
  });
}
