import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/version_updates/version.dart';

void main() {
  group('Version', () {
    group('constructor', () {
      test('creates version with major, minor, patch', () {
        final version = Version(1, 2, 3);
        expect(version.major, 1);
        expect(version.minor, 2);
        expect(version.patch, 3);
      });

      test('creates version with preRelease', () {
        final version = Version(1, 0, 0, preRelease: ['alpha', '1']);
        expect(version.isPreRelease, true);
        expect(version.preRelease, ['alpha', '1']);
      });

      test('creates version with build', () {
        final version = Version(1, 0, 0, build: 'build.123');
        expect(version.build, 'build.123');
      });

      test('throws on negative major version', () {
        expect(() => Version(-1, 0, 0), throwsArgumentError);
      });

      test('throws on negative minor version', () {
        expect(() => Version(0, -1, 0), throwsArgumentError);
      });

      test('throws on negative patch version', () {
        expect(() => Version(0, 0, -1), throwsArgumentError);
      });

      test('throws on empty preRelease segment', () {
        expect(
          () => Version(1, 0, 0, preRelease: ['alpha', '']),
          throwsArgumentError,
        );
      });

      test('throws on invalid preRelease characters', () {
        expect(
          () => Version(1, 0, 0, preRelease: ['alpha@beta']),
          throwsFormatException,
        );
      });

      test('throws on invalid build characters', () {
        expect(
          () => Version(1, 0, 0, build: 'build@123'),
          throwsFormatException,
        );
      });
    });

    group('parse', () {
      test('parses simple version', () {
        final version = Version.parse('1.2.3');
        expect(version.major, 1);
        expect(version.minor, 2);
        expect(version.patch, 3);
      });

      test('parses version with only major', () {
        final version = Version.parse('5');
        expect(version.major, 5);
        expect(version.minor, 0);
        expect(version.patch, 0);
      });

      test('parses version with major.minor', () {
        final version = Version.parse('3.7');
        expect(version.major, 3);
        expect(version.minor, 7);
        expect(version.patch, 0);
      });

      test('parses version with preRelease', () {
        final version = Version.parse('1.0.0-alpha.1');
        expect(version.major, 1);
        expect(version.minor, 0);
        expect(version.patch, 0);
        expect(version.isPreRelease, true);
        expect(version.preRelease, ['alpha', '1']);
      });

      test('parses version with build', () {
        final version = Version.parse('1.0.0+build.123');
        expect(version.build, 'build.123');
      });

      test('parses version with preRelease and build', () {
        final version = Version.parse('1.0.0-beta.2+build.456');
        expect(version.isPreRelease, true);
        expect(version.preRelease, ['beta', '2']);
        expect(version.build, 'build.456');
      });

      test('throws on null version string', () {
        expect(() => Version.parse(null), throwsFormatException);
      });

      test('throws on empty version string', () {
        expect(() => Version.parse(''), throwsFormatException);
      });

      test('throws on whitespace-only version string', () {
        expect(() => Version.parse('   '), throwsFormatException);
      });

      test('throws on invalid version format', () {
        expect(() => Version.parse('invalid'), throwsFormatException);
      });
    });

    group('comparison operators', () {
      test('less than works correctly', () {
        expect(Version(1, 0, 0) < Version(2, 0, 0), true);
        expect(Version(1, 0, 0) < Version(1, 1, 0), true);
        expect(Version(1, 0, 0) < Version(1, 0, 1), true);
        expect(Version(2, 0, 0) < Version(1, 0, 0), false);
      });

      test('greater than works correctly', () {
        expect(Version(2, 0, 0) > Version(1, 0, 0), true);
        expect(Version(1, 1, 0) > Version(1, 0, 0), true);
        expect(Version(1, 0, 1) > Version(1, 0, 0), true);
        expect(Version(1, 0, 0) > Version(2, 0, 0), false);
      });

      test('equals works correctly', () {
        expect(Version(1, 2, 3) == Version(1, 2, 3), true);
        expect(Version(1, 2, 3) == Version(1, 2, 4), false);
      });

      test('less than or equal works correctly', () {
        expect(Version(1, 0, 0) <= Version(1, 0, 0), true);
        expect(Version(1, 0, 0) <= Version(2, 0, 0), true);
        expect(Version(2, 0, 0) <= Version(1, 0, 0), false);
      });

      test('greater than or equal works correctly', () {
        expect(Version(1, 0, 0) >= Version(1, 0, 0), true);
        expect(Version(2, 0, 0) >= Version(1, 0, 0), true);
        expect(Version(1, 0, 0) >= Version(2, 0, 0), false);
      });

      test('comparison with non-Version returns false', () {
        expect(Version(1, 0, 0) == 'not a version', false);
        expect(Version(1, 0, 0) < 'string', false);
        expect(Version(1, 0, 0) > 123, false);
      });
    });

    group('preRelease comparison', () {
      test('release version is greater than preRelease', () {
        expect(Version(1, 0, 0) > Version(1, 0, 0, preRelease: ['alpha']), true);
      });

      test('preRelease is less than release', () {
        expect(Version(1, 0, 0, preRelease: ['alpha']) < Version(1, 0, 0), true);
      });

      test('numeric preRelease segments compare numerically', () {
        expect(
          Version(1, 0, 0, preRelease: ['alpha', '2']) >
              Version(1, 0, 0, preRelease: ['alpha', '1']),
          true,
        );
      });

      test('alphabetic preRelease segments compare lexically', () {
        expect(
          Version(1, 0, 0, preRelease: ['beta']) >
              Version(1, 0, 0, preRelease: ['alpha']),
          true,
        );
      });

      test('longer preRelease is greater when prefix matches', () {
        expect(
          Version(1, 0, 0, preRelease: ['alpha', '1']) >
              Version(1, 0, 0, preRelease: ['alpha']),
          true,
        );
      });
    });

    group('compareTo', () {
      test('returns negative for lower version', () {
        expect(Version(1, 0, 0).compareTo(Version(2, 0, 0)), lessThan(0));
      });

      test('returns positive for higher version', () {
        expect(Version(2, 0, 0).compareTo(Version(1, 0, 0)), greaterThan(0));
      });

      test('returns zero for equal versions', () {
        expect(Version(1, 2, 3).compareTo(Version(1, 2, 3)), equals(0));
      });

      test('throws on null argument', () {
        expect(
          () => Version(1, 0, 0).compareTo(null),
          throwsArgumentError,
        );
      });
    });

    group('increment methods', () {
      test('incrementMajor increments major and resets others', () {
        final version = Version(1, 2, 3, preRelease: ['alpha'], build: 'build');
        final incremented = version.incrementMajor();
        expect(incremented.major, 2);
        expect(incremented.minor, 0);
        expect(incremented.patch, 0);
        expect(incremented.isPreRelease, false);
        expect(incremented.build, '');
      });

      test('incrementMinor increments minor and resets patch', () {
        final version = Version(1, 2, 3);
        final incremented = version.incrementMinor();
        expect(incremented.major, 1);
        expect(incremented.minor, 3);
        expect(incremented.patch, 0);
      });

      test('incrementPatch increments patch only', () {
        final version = Version(1, 2, 3);
        final incremented = version.incrementPatch();
        expect(incremented.major, 1);
        expect(incremented.minor, 2);
        expect(incremented.patch, 4);
      });

      test('incrementPreRelease increments numeric segment', () {
        final version = Version(1, 0, 0, preRelease: ['alpha', '1']);
        final incremented = version.incrementPreRelease();
        expect(incremented.preRelease, ['alpha', '2']);
      });

      test('incrementPreRelease adds 1 when no numeric segment', () {
        final version = Version(1, 0, 0, preRelease: ['alpha']);
        final incremented = version.incrementPreRelease();
        expect(incremented.preRelease, ['alpha', '1']);
      });

      test('incrementPreRelease throws on non-preRelease', () {
        final version = Version(1, 0, 0);
        expect(() => version.incrementPreRelease(), throwsException);
      });
    });

    group('toString', () {
      test('formats simple version correctly', () {
        expect(Version(1, 2, 3).toString(), '1.2.3');
      });

      test('formats version with preRelease', () {
        expect(
          Version(1, 0, 0, preRelease: ['alpha', '1']).toString(),
          '1.0.0-alpha.1',
        );
      });

      test('formats version with build', () {
        expect(
          Version(1, 0, 0, build: 'build.123').toString(),
          '1.0.0+build.123',
        );
      });

      test('formats version with preRelease and build', () {
        expect(
          Version(1, 0, 0, preRelease: ['beta'], build: '456').toString(),
          '1.0.0-beta+456',
        );
      });

      test('handles empty build', () {
        // Note: build with whitespace throws FormatException
        // Only empty string is valid for "no build"
        expect(Version(1, 0, 0, build: '').toString(), '1.0.0');
      });
    });

    group('hashCode', () {
      test('equal versions have same hashCode', () {
        final v1 = Version(1, 2, 3);
        final v2 = Version(1, 2, 3);
        expect(v1.hashCode, v2.hashCode);
      });

      test('different versions have different hashCode', () {
        final v1 = Version(1, 2, 3);
        final v2 = Version(1, 2, 4);
        expect(v1.hashCode, isNot(v2.hashCode));
      });
    });

    group('isPreRelease', () {
      test('returns false for release version', () {
        expect(Version(1, 0, 0).isPreRelease, false);
      });

      test('returns true for preRelease version', () {
        expect(Version(1, 0, 0, preRelease: ['alpha']).isPreRelease, true);
      });
    });

    group('preRelease getter', () {
      test('returns copy of preRelease list', () {
        final original = ['alpha', '1'];
        final version = Version(1, 0, 0, preRelease: original);
        final preRelease = version.preRelease;
        
        // Modifying returned list should not affect original
        preRelease.add('modified');
        expect(version.preRelease.length, 2);
      });
    });
  });
}
