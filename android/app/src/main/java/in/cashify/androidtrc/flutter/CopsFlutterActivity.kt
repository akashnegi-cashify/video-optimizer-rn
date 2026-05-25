package `in`.cashify.androidtrc.flutter

import android.content.Context
import android.content.Intent
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

/**
 * Host-side Activity that renders the Flutter UI.
 *
 * Uses [FlutterFragmentActivity] (NOT [io.flutter.embedding.android.FlutterActivity]) to
 * preserve the FragmentActivity semantics of the original Flutter project. Several plugins
 * (notably local_auth) require a FragmentActivity host.
 *
 * IMPORTANT: We deliberately do NOT use `withCachedEngine(...)` here. Pre-warmed engines
 * run Dart code at App.onCreate() time, before any Activity exists, so ActivityAware
 * plugins (flutter_local_notifications, image_picker, local_auth, permission_handler,
 * etc.) see `mainActivity == null` and NPE the first time Dart calls them. Letting
 * FlutterFragmentActivity own a fresh engine ensures the activity attaches to the engine
 * before Dart runs, so plugins always have an Activity reference.
 *
 * Trade-off: slightly slower cold start (engine + Dart spin up on Activity start rather
 * than during App.onCreate). Net effect is ~300ms vs ~100ms to first frame. Worth it.
 */
class CopsFlutterActivity : FlutterFragmentActivity() {

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    // Register the in.cashify.trc/plugin MethodChannel handlers on THIS activity's engine.
    FlutterEngineManager.configureEngine(flutterEngine, applicationContext)
    // RN-leaf hand-off bridge — needs an Activity context to start RnLeafActivity.
    CopsRnLeafBridge.configureEngine(flutterEngine, this)
  }

  companion object {
    /**
     * Launches CopsFlutterActivity with a fresh, activity-owned FlutterEngine.
     * (FlutterFragmentActivity falls back to its new-engine path when no `withCachedEngine`
     * intent extras are present.)
     */
    fun newIntent(context: Context): Intent =
      Intent(context, CopsFlutterActivity::class.java)
  }
}
