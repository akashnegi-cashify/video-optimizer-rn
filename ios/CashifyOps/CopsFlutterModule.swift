// =============================================================================
// CopsFlutterModule.swift
//
// React Native bridge exposing `launchFlutter()` to JS. Presents a
// FlutterViewController backed by the cached engine.
//
// In Phase 1 the AppDelegate's root view controller IS the FlutterViewController,
// so this method exists for future re-entry scenarios where RN screens want to
// open Flutter UIs mid-session.
// =============================================================================

import Flutter
import Foundation
import React
import UIKit

@objc(CopsFlutter)
class CopsFlutterModule: NSObject {

  @objc static func requiresMainQueueSetup() -> Bool { true }

  @objc func launchFlutter(_ resolve: @escaping RCTPromiseResolveBlock,
                           rejecter reject: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      guard let rootVC = self.rootViewController() else {
        reject("NO_ROOT_VC", "No root view controller available", nil)
        return
      }

      let engine = CopsFlutterEngineManager.shared.engine
      let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
      flutterVC.modalPresentationStyle = .fullScreen

      let topVC = self.topmostViewController(from: rootVC)
      topVC.present(flutterVC, animated: false, completion: {
        resolve(nil)
      })
    }
  }

  private func rootViewController() -> UIViewController? {
    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      return scene.windows.first(where: { $0.isKeyWindow })?.rootViewController
        ?? scene.windows.first?.rootViewController
    }
    return nil
  }

  private func topmostViewController(from vc: UIViewController) -> UIViewController {
    var top: UIViewController = vc
    while let presented = top.presentedViewController {
      top = presented
    }
    return top
  }
}
