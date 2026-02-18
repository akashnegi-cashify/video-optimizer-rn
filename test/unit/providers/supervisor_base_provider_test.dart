import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/supervisor/providers/supervisor_base_provider.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for SupervisorBaseProvider - the base class for supervisor-related providers.
/// This is a base class that provides shared functionality for part variation management.
void main() {
  group('SupervisorBaseProvider', () {
    late TestableSupervisorBaseProvider provider;

    setUp(() {
      provider = TestableSupervisorBaseProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should initialize with null partVariationList by default', () {
        final emptyProvider = TestableSupervisorBaseProvider();
        expect(emptyProvider.partVariationList, isNull);
        emptyProvider.dispose();
      });

      test('should initialize with provided partVariationListResponse', () {
        final partList = [
          PartVariationData(partId: 1, partName: 'Screen', category: 'Display'),
          PartVariationData(partId: 2, partName: 'Battery', category: 'Power'),
        ];

        final providerWithData = TestableSupervisorBaseProvider(
          partVariationListResponse: partList,
        );

        expect(providerWithData.partVariationList, isNotNull);
        expect(providerWithData.partVariationList!.length, 2);
        providerWithData.dispose();
      });
    });

    group('partVariationList getter', () {
      test('should return null when list is null and no search query', () {
        expect(provider.partVariationList, isNull);
      });

      test('should return full list when no search query', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
          PartVariationData(partId: 2, partName: 'Battery'),
        ];

        expect(provider.partVariationList!.length, 2);
      });

      test('should filter list by partName when search query is set', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen Display'),
          PartVariationData(partId: 2, partName: 'Battery'),
          PartVariationData(partId: 3, partName: 'Back Screen'),
        ];

        provider.searchQuery = 'Screen';

        final filteredList = provider.partVariationList;
        expect(filteredList!.length, 2);
        expect(filteredList[0].partName, 'Screen Display');
        expect(filteredList[1].partName, 'Back Screen');
      });

      test('should filter case-insensitively', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'SCREEN'),
          PartVariationData(partId: 2, partName: 'screen'),
          PartVariationData(partId: 3, partName: 'Battery'),
        ];

        provider.searchQuery = 'screen';

        expect(provider.partVariationList!.length, 2);
      });

      test('should return empty list when search query matches nothing', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
          PartVariationData(partId: 2, partName: 'Battery'),
        ];

        provider.searchQuery = 'nonexistent';

        expect(provider.partVariationList, isEmpty);
      });
    });

    group('partVariationList setter', () {
      test('should set list and notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Test'),
        ];

        expect(tracker.callCount, 1);
        expect(provider.partVariationList!.length, 1);
      });

      test('should allow setting null', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Test'),
        ];
        provider.partVariationList = null;

        expect(provider.partVariationList, isNull);
      });
    });

    group('getCompletePartVariationList', () {
      test('should return null when list is null', () {
        expect(provider.getCompletePartVariationList(), isNull);
      });

      test('should return full list regardless of search query', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
          PartVariationData(partId: 2, partName: 'Battery'),
        ];

        provider.searchQuery = 'Screen';

        // partVariationList getter returns filtered list
        expect(provider.partVariationList!.length, 1);

        // getCompletePartVariationList returns full list
        expect(provider.getCompletePartVariationList()!.length, 2);
      });
    });

    group('updateImage', () {
      test('should update imageUrl for matching partId', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
          PartVariationData(partId: 2, partName: 'Battery'),
        ];

        provider.updateImage(1, 'https://example.com/image.jpg');

        expect(provider.partVariationList![0].imageUrl, 'https://example.com/image.jpg');
        expect(provider.partVariationList![1].imageUrl, isNull);
      });

      test('should notify listeners when image is updated', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
        ];

        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.updateImage(1, 'https://example.com/image.jpg');

        expect(tracker.callCount, 1);
      });

      test('should not throw when partId not found', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
        ];

        expect(
          () => provider.updateImage(999, 'https://example.com/image.jpg'),
          returnsNormally,
        );
      });

      test('should not update when list is null', () {
        expect(
          () => provider.updateImage(1, 'https://example.com/image.jpg'),
          returnsNormally,
        );
      });
    });

    group('updateUserSelectedVariantId', () {
      test('should update userSelectedVariantId for matching partId', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
          PartVariationData(partId: 2, partName: 'Battery'),
        ];

        provider.updateUserSelectedVariantId(1, 'variant_123');

        expect(provider.partVariationList![0].userSelectedVariantId, 'variant_123');
        expect(provider.partVariationList![1].userSelectedVariantId, isNull);
      });

      test('should notify listeners when variant is updated', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
        ];

        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.updateUserSelectedVariantId(1, 'variant_123');

        expect(tracker.callCount, 1);
      });

      test('should not throw when partId not found', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
        ];

        expect(
          () => provider.updateUserSelectedVariantId(999, 'variant_123'),
          returnsNormally,
        );
      });
    });

    group('resetQuestion', () {
      test('should reset userSelectedVariantId and imageUrl for matching partId', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
        ];

        // Set values first
        provider.updateUserSelectedVariantId(1, 'variant_123');
        provider.updateImage(1, 'https://example.com/image.jpg');

        // Verify values are set
        expect(provider.partVariationList![0].userSelectedVariantId, 'variant_123');
        expect(provider.partVariationList![0].imageUrl, 'https://example.com/image.jpg');

        // Reset
        provider.resetQuestion(1);

        // Verify values are cleared
        expect(provider.partVariationList![0].userSelectedVariantId, isNull);
        expect(provider.partVariationList![0].imageUrl, isNull);
      });

      test('should notify listeners when question is reset', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
        ];

        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.resetQuestion(1);

        expect(tracker.callCount, 1);
      });

      test('should not throw when partId not found', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
        ];

        expect(() => provider.resetQuestion(999), returnsNormally);
      });
    });

    group('searchQuery setter', () {
      test('should set search query and notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.searchQuery = 'test';

        expect(tracker.callCount, 1);
      });

      test('should allow setting null', () {
        provider.searchQuery = 'test';
        provider.searchQuery = null;

        expect(provider.partVariationList, isNull);
      });

      test('should allow setting empty string', () {
        provider.partVariationList = [
          PartVariationData(partId: 1, partName: 'Screen'),
          PartVariationData(partId: 2, partName: 'Battery'),
        ];

        provider.searchQuery = '';

        // Empty string should return full list
        expect(provider.partVariationList!.length, 2);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(SupervisorBaseProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = TestableSupervisorBaseProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });

  group('SupervisorBaseProvider edge cases', () {
    test('should handle special characters in search query', () {
      final provider = TestableSupervisorBaseProvider();
      provider.partVariationList = [
        PartVariationData(partId: 1, partName: 'Screen & Display'),
        PartVariationData(partId: 2, partName: 'Battery'),
      ];

      provider.searchQuery = '&';

      expect(provider.partVariationList!.length, 1);
      expect(provider.partVariationList![0].partName, 'Screen & Display');

      provider.dispose();
    });

    test('should handle unicode in search query', () {
      final provider = TestableSupervisorBaseProvider();
      provider.partVariationList = [
        PartVariationData(partId: 1, partName: 'スクリーン'),
        PartVariationData(partId: 2, partName: 'Battery'),
      ];

      provider.searchQuery = 'スク';

      expect(provider.partVariationList!.length, 1);

      provider.dispose();
    });

    test('should handle large list', () {
      final provider = TestableSupervisorBaseProvider();
      provider.partVariationList = List.generate(
        1000,
        (index) => PartVariationData(partId: index, partName: 'Part $index'),
      );

      expect(provider.partVariationList!.length, 1000);

      provider.searchQuery = 'Part 99';

      // Should match Part 99, Part 990-999
      expect(provider.partVariationList!.length, 11);

      provider.dispose();
    });

    test('should handle multiple updates to same partId', () {
      final provider = TestableSupervisorBaseProvider();
      provider.partVariationList = [
        PartVariationData(partId: 1, partName: 'Screen'),
      ];

      // Multiple image updates
      provider.updateImage(1, 'url1');
      expect(provider.partVariationList![0].imageUrl, 'url1');

      provider.updateImage(1, 'url2');
      expect(provider.partVariationList![0].imageUrl, 'url2');

      // Multiple variant updates
      provider.updateUserSelectedVariantId(1, 'v1');
      expect(provider.partVariationList![0].userSelectedVariantId, 'v1');

      provider.updateUserSelectedVariantId(1, 'v2');
      expect(provider.partVariationList![0].userSelectedVariantId, 'v2');

      provider.dispose();
    });
  });
}

/// Testable subclass that extends the 'base' class.
/// Marked as 'final' as required by Dart's class modifier rules.
final class TestableSupervisorBaseProvider extends SupervisorBaseProvider {
  TestableSupervisorBaseProvider({super.partVariationListResponse});
}
