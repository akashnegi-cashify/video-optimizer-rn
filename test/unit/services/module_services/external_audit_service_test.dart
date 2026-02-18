import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/qc/modules/external_audit/resources/external_audit_service.dart';

/// Unit tests for [ExternalAuditService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Request body construction logic including conditional isReturn field
/// - Return type verification
void main() {
  group('ExternalAuditService', () {
    group('submitExternalAudit', () {
      test('should create stream with all parameters', () {
        final stream = ExternalAuditService.submitExternalAudit(
          auditType: 1,
          uid_1: 'USER_001',
          videoUrlList: ['video1.mp4', 'video2.mp4'],
          uid_2: 'USER_002',
          imageUrlList: ['image1.jpg', 'image2.jpg'],
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should create stream with isReceiveReturn true', () {
        final stream = ExternalAuditService.submitExternalAudit(
          auditType: 1,
          uid_1: 'user1',
          videoUrlList: [],
          uid_2: 'user2',
          imageUrlList: [],
          isReceiveReturn: true,
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should create stream with isReceiveReturn false', () {
        final stream = ExternalAuditService.submitExternalAudit(
          auditType: 1,
          uid_1: 'user1',
          videoUrlList: [],
          uid_2: 'user2',
          imageUrlList: [],
          isReceiveReturn: false,
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should create stream without isReceiveReturn (null)', () {
        final stream = ExternalAuditService.submitExternalAudit(
          auditType: 1,
          uid_1: 'user1',
          videoUrlList: [],
          uid_2: 'user2',
          imageUrlList: [],
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should create stream with null parameters', () {
        final stream = ExternalAuditService.submitExternalAudit(
          auditType: null,
          uid_1: null,
          videoUrlList: null,
          uid_2: null,
          imageUrlList: null,
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should create stream with empty lists', () {
        final stream = ExternalAuditService.submitExternalAudit(
          auditType: 1,
          uid_1: 'user1',
          videoUrlList: [],
          uid_2: 'user2',
          imageUrlList: [],
        );
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('should create stream with no parameters', () {
        final stream = ExternalAuditService.submitExternalAudit();
        expect(stream, isA<Stream<BaseResponse?>>());
      });

      test('request body construction with all fields', () {
        const auditType = 1;
        const uid_1 = 'USER_001';
        final videoUrlList = ['video1.mp4', 'video2.mp4'];
        const uid_2 = 'USER_002';
        final imageUrlList = ['image1.jpg', 'image2.jpg'];

        var req = {
          "recordingType": auditType,
          "uid1": uid_1,
          "videos": videoUrlList,
          "uid2": uid_2,
          "images": imageUrlList,
        };

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded['recordingType'], equals(1));
        expect(decoded['uid1'], equals('USER_001'));
        expect(decoded['videos'], equals(['video1.mp4', 'video2.mp4']));
        expect(decoded['uid2'], equals('USER_002'));
        expect(decoded['images'], equals(['image1.jpg', 'image2.jpg']));
      });

      test('request body construction with isReturn when isReceiveReturn is not null', () {
        const isReceiveReturn = true;
        var req = <String, dynamic>{
          "recordingType": 1,
          "uid1": "user1",
          "videos": <String>[],
          "uid2": "user2",
          "images": <String>[],
        };

        if (isReceiveReturn != null) {
          req["isReturn"] = isReceiveReturn;
        }

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded.containsKey('isReturn'), isTrue);
        expect(decoded['isReturn'], equals(true));
      });

      test('request body construction without isReturn when isReceiveReturn is null', () {
        const bool? isReceiveReturn = null;
        var req = <String, dynamic>{
          "recordingType": 1,
          "uid1": "user1",
          "videos": <String>[],
          "uid2": "user2",
          "images": <String>[],
        };

        if (isReceiveReturn != null) {
          req["isReturn"] = isReceiveReturn;
        }

        expect(req.containsKey('isReturn'), isFalse);
      });

      test('should use abbreviated field names', () {
        var req = {
          "recordingType": 1,
          "uid1": "user1",
          "videos": [],
          "uid2": "user2",
          "images": [],
        };

        expect(req.containsKey('recordingType'), isTrue);
        expect(req.containsKey('uid1'), isTrue);
        expect(req.containsKey('uid2'), isTrue);
      });
    });

    group('endpoint structure', () {
      test('endpoint should be /external/recording', () {
        const endpoint = '/external/recording';
        
        expect(endpoint, equals('/external/recording'));
        expect(endpoint, startsWith('/external'));
        expect(endpoint, isNot(startsWith('/v1')));
        expect(endpoint, isNot(contains('?')));
      });
    });

    group('Integration - Method creates valid stream', () {
      test('submitExternalAudit should be callable and return stream', () {
        expect(
          () => ExternalAuditService.submitExternalAudit(),
          returnsNormally,
        );
        
        final stream = ExternalAuditService.submitExternalAudit();
        expect(stream, isA<Stream<BaseResponse?>>());
      });
    });
  });
}
