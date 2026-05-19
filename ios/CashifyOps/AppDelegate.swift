// =============================================================================
// AppDelegate.swift
//
// RN host AppDelegate. In Phase 1 we:
//   1. Configure Firebase (parity with the original Flutter AppDelegate).
//   2. Pre-warm the cached Flutter engine + register MethodChannels.
//   3. Boot React Native — even though Phase 1 doesn't render any RN UI to the
//      user, the JS context is needed so the CopsFlutter bridge module exists
//      for future RN screens.
//   4. Present a FlutterViewController as the visible root view controller.
// =============================================================================

import Flutter
import FirebaseCore
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  var reactNativeDelegate: ReactNativeDelegate?
  var reactNativeFactory: RCTReactNativeFactory?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {

    // 1. Firebase first (some plugins instantiate Firebase services during
    //    GeneratedPluginRegistrant.register; configure must come before that).
    FirebaseApp.configure()

    // 2. Pre-warm the cached Flutter engine and wire MethodChannels.
    CopsFlutterEngineManager.shared.bootstrap()

    // 3. Boot React Native in the background so the JS bridge exists for
    //    any RN-callable native modules. The RN root view is NOT made visible.
    let delegate = ReactNativeDelegate()
    let factory = RCTReactNativeFactory(delegate: delegate)
    delegate.dependencyProvider = RCTAppDependencyProvider()
    reactNativeDelegate = delegate
    reactNativeFactory = factory

    // 4. Present the Flutter UI as the visible root.
    let flutterVC = FlutterViewController(
      engine: CopsFlutterEngineManager.shared.engine,
      nibName: nil,
      bundle: nil
    )
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = flutterVC
    window.makeKeyAndVisible()
    self.window = window

    // Start RN with a hidden host window so JS modules load. This window is
    // never made key/visible in Phase 1.
    let rnHostWindow = UIWindow(frame: .zero)
    factory.startReactNative(
      withModuleName: "CashifyOps",
      in: rnHostWindow,
      launchOptions: launchOptions
    )

    return true
  }
}

class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
  override func sourceURL(for bridge: RCTBridge) -> URL? {
    self.bundleURL()
  }

  override func bundleURL() -> URL? {
#if DEBUG
    RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
#else
    Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
  }
}
