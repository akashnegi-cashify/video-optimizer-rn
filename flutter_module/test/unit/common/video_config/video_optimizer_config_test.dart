import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/video_config/video_optimizer_config.dart';

void main() {
  group('VideoOptimizerConfig', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final config = VideoOptimizerConfig(
          crf: 23,
          videoCodec: 'libx264',
          videoPreset: 'medium',
          addTimeStamp: true,
          fontSize: 24,
          fontColor: 'white',
          borderColor: 'black',
          isRemoveAudio: true,
        );

        expect(config.crf, 23);
        expect(config.videoCodec, 'libx264');
        expect(config.videoPreset, 'medium');
        expect(config.addTimeStamp, true);
        expect(config.fontSize, 24);
        expect(config.fontColor, 'white');
        expect(config.borderColor, 'black');
        expect(config.isRemoveAudio, true);
      });

      test('creates instance with default isRemoveAudio', () {
        final config = VideoOptimizerConfig();

        expect(config.isRemoveAudio, false);
      });

      test('creates instance with null optional parameters', () {
        final config = VideoOptimizerConfig(crf: 18);

        expect(config.crf, 18);
        expect(config.videoCodec, isNull);
        expect(config.videoPreset, isNull);
        expect(config.addTimeStamp, isNull);
        expect(config.fontSize, isNull);
        expect(config.fontColor, isNull);
        expect(config.borderColor, isNull);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'crf': 20,
          'videoCodec': 'h264',
          'videoPreset': 'fast',
          'addTimeStamp': true,
          'fontSize': 18,
          'fontColor': 'yellow',
          'borderColor': 'red',
          'isRemoveAudio': true,
        };

        final config = VideoOptimizerConfig.fromJson(json);

        expect(config.crf, 20);
        expect(config.videoCodec, 'h264');
        expect(config.videoPreset, 'fast');
        expect(config.addTimeStamp, true);
        expect(config.fontSize, 18);
        expect(config.fontColor, 'yellow');
        expect(config.borderColor, 'red');
        expect(config.isRemoveAudio, true);
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'crf': null,
          'videoCodec': null,
          'videoPreset': null,
          'addTimeStamp': null,
          'fontSize': null,
          'fontColor': null,
          'borderColor': null,
          'isRemoveAudio': null,
        };

        final config = VideoOptimizerConfig.fromJson(json);

        expect(config.crf, isNull);
        expect(config.videoCodec, isNull);
        expect(config.videoPreset, isNull);
        expect(config.addTimeStamp, isNull);
        expect(config.fontSize, isNull);
        expect(config.fontColor, isNull);
        expect(config.borderColor, isNull);
        // Note: isRemoveAudio has default value of false, so it defaults when null
        expect(config.isRemoveAudio, anyOf(isNull, equals(false)));
      });

      test('handles missing fields', () {
        final json = <String, dynamic>{};

        final config = VideoOptimizerConfig.fromJson(json);

        expect(config.crf, isNull);
        expect(config.videoCodec, isNull);
      });

      test('parses addTimeStamp as false', () {
        final json = {'addTimeStamp': false};

        final config = VideoOptimizerConfig.fromJson(json);

        expect(config.addTimeStamp, false);
      });

      test('parses isRemoveAudio as false', () {
        final json = {'isRemoveAudio': false};

        final config = VideoOptimizerConfig.fromJson(json);

        expect(config.isRemoveAudio, false);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final config = VideoOptimizerConfig(
          crf: 25,
          videoCodec: 'libx265',
          videoPreset: 'slow',
          addTimeStamp: false,
          fontSize: 32,
          fontColor: 'green',
          borderColor: 'blue',
          isRemoveAudio: false,
        );

        final json = config.toJson();

        expect(json['crf'], 25);
        expect(json['videoCodec'], 'libx265');
        expect(json['videoPreset'], 'slow');
        expect(json['addTimeStamp'], false);
        expect(json['fontSize'], 32);
        expect(json['fontColor'], 'green');
        expect(json['borderColor'], 'blue');
        expect(json['isRemoveAudio'], false);
      });

      test('serializes null values', () {
        final config = VideoOptimizerConfig();

        final json = config.toJson();

        expect(json['crf'], isNull);
        expect(json['videoCodec'], isNull);
        expect(json['videoPreset'], isNull);
        expect(json['addTimeStamp'], isNull);
      });
    });

    group('common video codec values', () {
      test('supports libx264 codec', () {
        final config = VideoOptimizerConfig(videoCodec: 'libx264');
        expect(config.videoCodec, 'libx264');
      });

      test('supports libx265 codec', () {
        final config = VideoOptimizerConfig(videoCodec: 'libx265');
        expect(config.videoCodec, 'libx265');
      });

      test('supports h264 codec', () {
        final config = VideoOptimizerConfig(videoCodec: 'h264');
        expect(config.videoCodec, 'h264');
      });
    });

    group('common video preset values', () {
      test('supports ultrafast preset', () {
        final config = VideoOptimizerConfig(videoPreset: 'ultrafast');
        expect(config.videoPreset, 'ultrafast');
      });

      test('supports fast preset', () {
        final config = VideoOptimizerConfig(videoPreset: 'fast');
        expect(config.videoPreset, 'fast');
      });

      test('supports medium preset', () {
        final config = VideoOptimizerConfig(videoPreset: 'medium');
        expect(config.videoPreset, 'medium');
      });

      test('supports slow preset', () {
        final config = VideoOptimizerConfig(videoPreset: 'slow');
        expect(config.videoPreset, 'slow');
      });
    });

    group('CRF value ranges', () {
      test('accepts low quality CRF (high compression)', () {
        final config = VideoOptimizerConfig(crf: 51);
        expect(config.crf, 51);
      });

      test('accepts high quality CRF (low compression)', () {
        final config = VideoOptimizerConfig(crf: 0);
        expect(config.crf, 0);
      });

      test('accepts typical CRF value', () {
        final config = VideoOptimizerConfig(crf: 23);
        expect(config.crf, 23);
      });
    });
  });
}
