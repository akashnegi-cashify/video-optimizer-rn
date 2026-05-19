// =============================================================================
// CopsFlutterEngineManager.swift
//
// Holds the cached FlutterEngine that powers the Flutter UI in add-to-app mode
// and registers the `in.cashify.trc/plugin` MethodChannel handlers ported from
// the original Flutter project's AppDelegate.
// =============================================================================

import Flutter
import FlutterPluginRegistrant
import Foundation

final class CopsFlutterEngineManager {

  static let shared = CopsFlutterEngineManager()

  private static let channelName = "in.cashify.trc/plugin"

  let engine = FlutterEngine(name: "cops_engine")
  private var channel: FlutterMethodChannel?

  private init() {}

  /// Call this once from AppDelegate.didFinishLaunching, BEFORE returning.
  func bootstrap() {
    engine.run()
    GeneratedPluginRegistrant.register(with: engine)
    registerChannels()
  }

  private func registerChannels() {
    let methodChannel = FlutterMethodChannel(
      name: Self.channelName,
      binaryMessenger: engine.binaryMessenger
    )
    methodChannel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else { return }
      switch call.method {
      case "userauthdetails":
        // Preserve original contract: response identifies the platform.
        result("ios")

      case "registerLogout":
        CopsLogoutBridge.shared.registerResult(result)
        // Do NOT call result(...) here — the bridge fires it later.

      case "getFlavor":
        // Read COPSFlavor key injected by the per-flavor xcconfig into Info.plist.
        let flavor = Bundle.main.object(forInfoDictionaryKey: "COPSFlavor") as? String
        result(flavor ?? "prod")

      default:
        // compressVideo and any other plugin-backed methods are handled by their
        // respective FlutterPlugin classes inside the engine — do NOT shadow them.
        result(FlutterMethodNotImplemented)
      }
    }
    self.channel = methodChannel
  }
}
