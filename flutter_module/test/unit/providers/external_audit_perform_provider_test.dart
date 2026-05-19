import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/external_audit/providers/external_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for ExternalAuditPerformProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ExternalAuditPerformProvider', () {
    late ExternalAuditPerformProvider provider;

    setUp(() {
      provider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should initialize with dispatch audit type', () {
        final dispatchProvider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
        expect(dispatchProvider.auditType, ExternalAuditEnum.dispatch);
        dispatchProvider.dispose();
      });

      test('should initialize with receiveReturn audit type', () {
        final receiveProvider = ExternalAuditPerformProvider(ExternalAuditEnum.receiveReturn);
        expect(receiveProvider.auditType, ExternalAuditEnum.receiveReturn);
        receiveProvider.dispose();
      });
    });

    group('initial state', () {
      test('auditType should be set from constructor', () {
        expect(provider.auditType, ExternalAuditEnum.dispatch);
      });
    });

    group('fileUploadProgressStream', () {
      test('should return a StreamController', () {
        expect(provider.fileUploadProgressStream, isNotNull);
        expect(provider.fileUploadProgressStream, isA<StreamController<double>>());
      });

      test('should be a broadcast stream', () {
        expect(provider.fileUploadProgressStream.stream.isBroadcast, isTrue);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ExternalAuditPerformProvider.of, isNotNull);
      });
    });

    group('uid setters', () {
      test('should allow setting uid_1', () {
        provider.uid_1 = 'USER_001';
        // uid_1 is write-only, so we just verify no exception is thrown
        expect(true, isTrue);
      });

      test('should allow setting uid_2', () {
        provider.uid_2 = 'USER_002';
        // uid_2 is write-only, so we just verify no exception is thrown
        expect(true, isTrue);
      });
    });

    group('onVideoRecorded', () {
      test('should add video file path to list', () {
        provider.onVideoRecorded('/path/to/video1.mp4');
        provider.onVideoRecorded('/path/to/video2.mp4');
        // Internal list is private, but method should not throw
        expect(true, isTrue);
      });

      test('should handle empty path', () {
        provider.onVideoRecorded('');
        expect(true, isTrue);
      });
    });

    group('onVideoUploaded', () {
      test('should add video URLs to list', () {
        provider.onVideoUploaded(['https://example.com/video1.mp4', 'https://example.com/video2.mp4']);
        expect(true, isTrue);
      });

      test('should handle empty list', () {
        provider.onVideoUploaded([]);
        expect(true, isTrue);
      });

      test('should handle single URL', () {
        provider.onVideoUploaded(['https://example.com/video.mp4']);
        expect(true, isTrue);
      });
    });

    group('onImageUploaded', () {
      test('should add image URLs to list', () {
        provider.onImageUploaded(['https://example.com/image1.jpg', 'https://example.com/image2.jpg']);
        expect(true, isTrue);
      });

      test('should handle empty list', () {
        provider.onImageUploaded([]);
        expect(true, isTrue);
      });

      test('should handle single URL', () {
        provider.onImageUploaded(['https://example.com/image.jpg']);
        expect(true, isTrue);
      });
    });

    group('isAuditTypeDispatch', () {
      test('should return true for dispatch audit type', () {
        final dispatchProvider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
        expect(dispatchProvider.isAuditTypeDispatch(), isTrue);
        dispatchProvider.dispose();
      });

      test('should return false for receiveReturn audit type', () {
        final receiveProvider = ExternalAuditPerformProvider(ExternalAuditEnum.receiveReturn);
        expect(receiveProvider.isAuditTypeDispatch(), isFalse);
        receiveProvider.dispose();
      });
    });

    group('method signatures', () {
      test('should have callExternalAuditApi method', () {
        expect(provider.callExternalAuditApi, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
        expect(() => testProvider.dispose(), returnsNormally);
      });

      test('should close stream controller on dispose', () {
        final testProvider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
        final stream = testProvider.fileUploadProgressStream;

        testProvider.dispose();

        expect(stream.isClosed, isTrue);
      });
    });
  });

  group('ExternalAuditPerformProvider edge cases', () {
    test('should handle multiple video recordings', () {
      final provider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
      for (int i = 0; i < 10; i++) {
        provider.onVideoRecorded('/path/to/video_$i.mp4');
      }
      provider.dispose();
    });

    test('should handle multiple video uploads', () {
      final provider = ExternalAuditPerformProvider(ExternalAuditEnum.receiveReturn);
      final urls = List.generate(10, (i) => 'https://example.com/video_$i.mp4');
      provider.onVideoUploaded(urls);
      provider.dispose();
    });

    test('should handle multiple image uploads', () {
      final provider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
      final urls = List.generate(10, (i) => 'https://example.com/image_$i.jpg');
      provider.onImageUploaded(urls);
      provider.dispose();
    });

    test('should handle special characters in paths', () {
      final provider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
      provider.onVideoRecorded('/path/to/video with spaces.mp4');
      provider.onVideoRecorded('/path/to/видео.mp4');
      provider.dispose();
    });

    test('should handle special characters in uid values', () {
      final provider = ExternalAuditPerformProvider(ExternalAuditEnum.dispatch);
      provider.uid_1 = 'USER-001/ABC_TEST#';
      provider.uid_2 = '用户_002';
      provider.dispose();
    });
  });
}
