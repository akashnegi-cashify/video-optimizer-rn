package `in`.cashify.androidtrc.flutter

import android.content.Context
import android.media.MediaMetadataRetriever
import android.net.Uri
import `in`.cashify.androidtrc.BuildConfig
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Registers the `in.cashify.trc/plugin` MethodChannel handlers on a FlutterEngine.
 *
 * NO PRE-WARMING is done here on purpose — see [CopsFlutterActivity] for the reasoning.
 * Each CopsFlutterActivity owns its own engine and calls [configureEngine] during
 * `configureFlutterEngine(...)` to wire up the host-side method channel.
 *
 * Channel methods (ported from the original Flutter MainActivity):
 *  - userauthdetails — returns "android"
 *  - registerLogout  — stores the Result in [CopsLogoutBridge] for global trigger
 *  - getFlavor       — returns BuildConfig.FLAVOR ("prod" | "beta" | "stage")
 *  - getVideoBitrate — ports the MediaMetadataRetriever helper
 *
 * compressVideo and other plugin-backed methods are handled by their own
 * FlutterPlugin classes (registered automatically by GeneratedPluginRegistrant).
 */
object FlutterEngineManager {

  private const val CHANNEL = "in.cashify.trc/plugin"

  fun configureEngine(engine: FlutterEngine, appContext: Context) {
    val channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
    channel.setMethodCallHandler { call, result ->
      when (call.method) {
        "userauthdetails" -> {
          // Preserve original contract from MainActivity.kt
          result.success("android")
        }
        "registerLogout" -> {
          CopsLogoutBridge.registerResult(result)
          // Intentionally do NOT call result.success — the bridge fires it later.
        }
        "getFlavor" -> {
          result.success(BuildConfig.FLAVOR)
        }
        "getVideoBitrate" -> {
          val path = call.argument<String>("path")
          if (path == null) {
            result.error("ARG_MISSING", "path is required", null)
          } else {
            try {
              result.success(getVideoBitrate(appContext, Uri.parse(path)))
            } catch (e: Exception) {
              result.error("BITRATE_ERROR", e.message, null)
            }
          }
        }
        else -> result.notImplemented()
      }
    }
  }

  private fun getVideoBitrate(context: Context, uri: Uri): Long {
    val retriever = MediaMetadataRetriever()
    try {
      retriever.setDataSource(context, uri)
      val bitrate = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_BITRATE)
      return bitrate?.toLong() ?: 0L
    } finally {
      retriever.release()
    }
  }
}
