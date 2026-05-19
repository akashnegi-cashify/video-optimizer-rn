package `in`.cashify.androidtrc.flutter

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

/**
 * React Native bridge exposing a single method `launchFlutter()` so JS code in App.tsx
 * (and any future RN screens) can present the Flutter UI on demand.
 *
 * In Phase 1 [MainActivity] already auto-launches Flutter on cold start, so this method
 * exists primarily to support re-entry from RN to Flutter in later migration phases.
 */
class CopsFlutterModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String = NAME

  @ReactMethod
  fun launchFlutter() {
    val activity = reactApplicationContext.currentActivity ?: return
    activity.startActivity(CopsFlutterActivity.newIntent(activity))
    activity.overridePendingTransition(0, 0)
  }

  companion object {
    const val NAME = "CopsFlutter"
  }
}
