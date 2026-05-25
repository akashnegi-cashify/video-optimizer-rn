package `in`.cashify.androidtrc.flutter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import `in`.cashify.androidtrc.RnLeafActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.lang.ref.WeakReference

/**
 * Flutter → RN hand-off bridge.
 *
 * Registers the `cops/rn_leaf` MethodChannel on a FlutterEngine. Flutter Dart code calls
 * `openRoute(route, params)` and we start [RnLeafActivity] with the route + params as
 * intent extras. The RN side reads them via its initial-props bundle.
 *
 * Lifecycle:
 *  - Flutter (login screen) calls openRoute → RnLeafActivity launches (Flutter activity stays
 *    in the back stack).
 *  - When the RN flow finishes, RnLeafActivity calls finish() and Flutter is revealed again.
 *  - From RN, [`in.cashify.androidtrc.RnLeafModule.finishLeaf`] handles the close call.
 *
 * Why a separate bridge object (not reusing FlutterEngineManager)? RN leaf launches need an
 * Activity context, not just an Application context. We capture the activity weakly when the
 * FlutterActivity attaches and use it to start the RN activity. The existing
 * FlutterEngineManager only had appContext.
 */
object CopsRnLeafBridge {

  private const val CHANNEL = "cops/rn_leaf"
  const val EXTRA_ROUTE = "rn_leaf_route"
  const val EXTRA_PARAMS_JSON = "rn_leaf_params_json"

  private var activityRef: WeakReference<Activity>? = null

  fun configureEngine(engine: FlutterEngine, hostActivity: Activity) {
    activityRef = WeakReference(hostActivity)
    val channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
    channel.setMethodCallHandler { call, result -> handle(call, result) }
  }

  private fun handle(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "openRoute" -> {
        val route = call.argument<String>("route")
        if (route.isNullOrBlank()) {
          result.error("ARG_MISSING", "route is required", null)
          return
        }
        val params: Map<String, Any?> = call.argument<Map<String, Any?>>("params") ?: emptyMap()
        val activity = activityRef?.get()
        if (activity == null) {
          result.error("NO_ACTIVITY", "host activity is gone", null)
          return
        }
        val intent = Intent(activity, RnLeafActivity::class.java).apply {
          putExtra(EXTRA_ROUTE, route)
          putExtra(EXTRA_PARAMS_JSON, JSONObject(params).toString())
        }
        activity.startActivity(intent)
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  /** Convert intent extras back into a Bundle the React initial-props builder can consume. */
  fun buildLaunchOptions(intent: Intent?): Bundle {
    val bundle = Bundle()
    val route = intent?.getStringExtra(EXTRA_ROUTE) ?: ""
    val paramsJson = intent?.getStringExtra(EXTRA_PARAMS_JSON) ?: "{}"
    bundle.putString("route", route)
    bundle.putString("paramsJson", paramsJson)
    return bundle
  }
}
