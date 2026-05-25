package `in`.cashify.androidtrc.flutter

import android.content.Context
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import `in`.cashify.androidtrc.RnLeafActivity

/**
 * Native module callable from JS as `NativeModules.RnLeaf`.
 *
 * Exposed methods:
 *  - finishLeaf(): closes the running RnLeafActivity, returning to Flutter
 *  - getFlutterMmkvDir(): returns the directory Flutter's `MMKV.initialize()` writes to.
 *    Flutter's mmkv plugin uses path_provider's getApplicationDocumentsDirectory() which on
 *    Android maps to `context.getDir("flutter", MODE_PRIVATE)` — i.e. `<dataDir>/app_flutter`.
 *    RN's `react-native-mmkv` defaults to `<dataDir>/files/mmkv` which is a DIFFERENT path,
 *    so passing this dir as the `path` option to the RN-side MMKV constructor is how we make
 *    both processes read/write the same store (mmapID "lego_shared", key "X-User-Auth", etc.)
 */
class RnLeafModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String = NAME

  @ReactMethod
  fun finishLeaf() {
    val activity = reactApplicationContext.currentActivity ?: return
    if (activity is RnLeafActivity) {
      activity.finish()
    }
  }

  @ReactMethod(isBlockingSynchronousMethod = true)
  fun getFlutterMmkvDir(): String {
    val flutterDir = reactApplicationContext.getDir("flutter", Context.MODE_PRIVATE)
    return "${flutterDir.absolutePath}/mmkv"
  }

  companion object {
    const val NAME = "RnLeaf"
  }
}
