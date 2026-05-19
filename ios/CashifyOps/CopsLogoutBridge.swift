// =============================================================================
// CopsLogoutBridge.swift
//
// Static-callback bridge that mirrors the Android `CopsLogoutBridge` object.
// Any native code can call CopsLogoutBridge.shared.callLogout() to trigger the
// Dart-side logout handler registered via the `registerLogout` MethodChannel.
// =============================================================================

import Flutter
import Foundation

final class CopsLogoutBridge {

  static let shared = CopsLogoutBridge()
  private var logoutResult: FlutterResult?
  private init() {}

  func registerResult(_ result: @escaping FlutterResult) {
    logoutResult = result
  }

  func callLogout() {
    guard let current = logoutResult else {
      NSLog("[CopsLogoutBridge] callLogout() invoked before Dart side registered. No-op.")
      return
    }
    NSLog("[CopsLogoutBridge] Triggering Dart-side logout handler.")
    current("")
    // FlutterResult can only be invoked once. Clear so Dart must re-register.
    logoutResult = nil
  }
}
