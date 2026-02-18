import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/provider/qc_trc_service_init_provider.dart';
import 'package:flutter_trc/src/services/qc_service.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

/// Testable subclass that allows us to override service initialization
class TestableQcTrcServiceInitProvider extends QcTrcServiceInitProvider {
  final bool mockIsQcLogin;
  
  TestableQcTrcServiceInitProvider({this.mockIsQcLogin = true});
  
  @override
  bool? isLoginFromQC() {
    return mockIsQcLogin;
  }
}

void main() {
  group('QcTrcServiceInitProvider', () {
    group('constructor', () {
      test('initializes with QcService when login is from QC', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: true);
        
        expect(provider.service, isA<QcService>());
      });

      test('initializes with TrcService when login is not from QC', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: false);
        
        expect(provider.service, isA<TrcService>());
      });
    });

    group('initService', () {
      test('sets QcService when isLoginFromQC returns true', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: true);
        
        // Service is already initialized in constructor
        expect(provider.service, isA<QcService>());
      });

      test('sets TrcService when isLoginFromQC returns false', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: false);
        
        expect(provider.service, isA<TrcService>());
      });
    });

    group('isLoginFromQC', () {
      test('returns boolean value', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: true);
        
        final result = provider.isLoginFromQC();
        
        expect(result, isA<bool?>());
      });

      test('can return true', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: true);
        
        expect(provider.isLoginFromQC(), true);
      });

      test('can return false', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: false);
        
        expect(provider.isLoginFromQC(), false);
      });
    });

    group('onServiceInitialized', () {
      test('is called during initialization', () {
        var callbackCalled = false;
        
        final provider = _CallbackTestProvider(
          onInitCallback: () => callbackCalled = true,
        );
        
        expect(callbackCalled, true);
      });
    });

    group('service property', () {
      test('service is BaseService type', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: true);
        
        expect(provider.service, isA<BaseService>());
      });

      test('service can be used for API calls', () {
        final provider = TestableQcTrcServiceInitProvider(mockIsQcLogin: true);
        
        // Verify service has expected methods
        expect(() => provider.service.getServiceGroup(), returnsNormally);
        expect(() => provider.service.isToAddUserAuth(), returnsNormally);
      });
    });
  });
}

/// Helper class to test onServiceInitialized callback
class _CallbackTestProvider extends QcTrcServiceInitProvider {
  final VoidCallback? onInitCallback;
  
  _CallbackTestProvider({this.onInitCallback});
  
  @override
  bool? isLoginFromQC() => true;
  
  @override
  void onServiceInitialized() {
    super.onServiceInitialized();
    onInitCallback?.call();
  }
}
