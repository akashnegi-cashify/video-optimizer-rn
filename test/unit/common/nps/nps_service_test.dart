import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/nps/nps_service.dart';
import 'package:flutter_trc/src/common/nps/resources/nps_question_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';

import '../../../helpers/mock_services.dart';

void main() {
  late MockBaseService mockService;

  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(<String, String>{});
    registerFallbackValue(<String, List<String>>{});
    registerFallbackValue('');
  });

  setUp(() {
    mockService = MockBaseService();
  });

  group('NpsService', () {
    group('getNpsQuestions', () {
      test('returns stream of NpsQuestionResponse', () {
        // Setup mock
        when(() => mockService.get<NpsQuestionResponse>(
              any(),
              any(),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((_) => Stream.value(
              NpsQuestionResponse(null, null),
            ));

        final stream = NpsService.getNpsQuestions(service: mockService);
        
        expect(stream, isA<Stream<NpsQuestionResponse>>());
      });

      test('calls correct endpoint', () async {
        when(() => mockService.get<NpsQuestionResponse>(
              any(),
              any(),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((_) => Stream.value(
              NpsQuestionResponse(null, null),
            ));

        await NpsService.getNpsQuestions(service: mockService).first;

        verify(() => mockService.get<NpsQuestionResponse>(
              '/nps/list',
              any(),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).called(1);
      });

      test('returns response from service', () async {
        final expectedResponse = NpsQuestionResponse(null, null);
        expectedResponse.npsResponse = NpsResponseData();
        
        when(() => mockService.get<NpsQuestionResponse>(
              any(),
              any(),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((_) => Stream.value(expectedResponse));

        final result = await NpsService.getNpsQuestions(service: mockService).first;

        expect(result.npsResponse, isNotNull);
      });
    });

    group('submitNpsQuestions', () {
      test('returns stream of BaseActionResponse', () {
        final body = <String, dynamic>{
          'txnId': 'test-txn-123',
          'pageNo': 1,
          'questions': [],
        };

        when(() => mockService.post<BaseActionResponse>(
              any(),
              any(),
              body: any(named: 'body'),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((_) => Stream.value(
              BaseActionResponse(null, null),
            ));

        final stream = NpsService.submitNpsQuestions(body, service: mockService);
        
        expect(stream, isA<Stream<BaseActionResponse>>());
      });

      test('calls correct endpoint', () async {
        final body = <String, dynamic>{
          'txnId': 'test-txn-123',
          'pageNo': 1,
          'questions': [],
        };

        when(() => mockService.post<BaseActionResponse>(
              any(),
              any(),
              body: any(named: 'body'),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((_) => Stream.value(
              BaseActionResponse(null, null),
            ));

        await NpsService.submitNpsQuestions(body, service: mockService).first;

        verify(() => mockService.post<BaseActionResponse>(
              '/nps/submit/question/app',
              any(),
              body: any(named: 'body'),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).called(1);
      });

      test('sends correct request body', () async {
        final body = <String, dynamic>{
          'txnId': 'test-txn-456',
          'pageNo': 2,
          'questions': [
            {'questionId': 1, 'selectedOptionIds': [5]},
            {'questionId': 2, 'value': 'Great service'},
          ],
        };

        String? capturedBody;
        when(() => mockService.post<BaseActionResponse>(
              any(),
              any(),
              body: any(named: 'body'),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((invocation) {
              capturedBody = invocation.namedArguments[#body] as String?;
              return Stream.value(BaseActionResponse(null, null));
            });

        await NpsService.submitNpsQuestions(body, service: mockService).first;

        expect(capturedBody, isNotNull);
        expect(capturedBody, contains('txnId'));
        expect(capturedBody, contains('test-txn-456'));
        expect(capturedBody, contains('pageNo'));
        expect(capturedBody, contains('questions'));
      });

      test('returns success response', () async {
        final body = <String, dynamic>{'txnId': 'test', 'questions': []};
        
        final expectedResponse = BaseActionResponse(null, null);
        expectedResponse.isSuccess = true;
        expectedResponse.successMessage = 'NPS submitted successfully';

        when(() => mockService.post<BaseActionResponse>(
              any(),
              any(),
              body: any(named: 'body'),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((_) => Stream.value(expectedResponse));

        final result = await NpsService.submitNpsQuestions(body, service: mockService).first;

        expect(result.isSuccess, true);
        expect(result.successMessage, 'NPS submitted successfully');
      });

      test('handles empty questions list', () async {
        final body = <String, dynamic>{
          'txnId': 'empty-test',
          'pageNo': 1,
          'questions': [],
        };

        when(() => mockService.post<BaseActionResponse>(
              any(),
              any(),
              body: any(named: 'body'),
              params: any(named: 'params'),
              headers: any(named: 'headers'),
            )).thenAnswer((_) => Stream.value(BaseActionResponse(null, null)));

        final stream = NpsService.submitNpsQuestions(body, service: mockService);
        
        expect(stream, isA<Stream<BaseActionResponse>>());
        await expectLater(stream, emits(isA<BaseActionResponse>()));
      });
    });
  });
}
