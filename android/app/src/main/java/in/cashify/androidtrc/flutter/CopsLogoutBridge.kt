package `in`.cashify.androidtrc.flutter

import android.util.Log
import io.flutter.plugin.common.MethodChannel

/**
 * Global static-callback bridge that mirrors the original `TRCDataSingleton.callLogout()`
 * companion-object pattern.
 *
 * Flow:
 *  1. Dart calls `registerLogout` via the MethodChannel.
 *  2. [FlutterEngineManager] forwards the [MethodChannel.Result] here via [registerResult].
 *  3. Anywhere in native code (RN bridge, MainActivity, etc.) can call [callLogout] to
 *     invoke the Dart-side handler.
 */
object CopsLogoutBridge {

  private const val TAG = "CopsLogoutBridge"
  private var logoutResult: MethodChannel.Result? = null

  fun registerResult(result: MethodChannel.Result) {
    logoutResult = result
  }

  @JvmStatic
  fun callLogout() {
    val current = logoutResult ?: run {
      Log.w(TAG, "callLogout() invoked before Dart side registered. No-op.")
      return
    }
    Log.i(TAG, "Triggering Dart-side logout handler.")
    try {
      current.success("")
    } finally {
      // The Result can only be invoked once; clear so a re-registration is required
      // before the next logout dispatch.
      logoutResult = null
    }
  }
}
