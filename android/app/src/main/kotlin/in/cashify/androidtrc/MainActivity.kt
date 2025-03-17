package `in`.cashify.androidtrc


import android.media.MediaMetadataRetriever
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    companion object {

        private var logoutResult: MethodChannel.Result? = null

        fun callLogout() {
            if (logoutResult != null) {
                Log.e("Logout called from AND", "")
                logoutResult?.success("");
            }
        }
    }

    private val CHANNEL = "in.cashify.trc/plugin"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine);



        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        ).setMethodCallHandler { call, result ->
            println("MainActivity--- CHANNEL = ${CHANNEL},METHOD NAME ${call.method}")
            when (call.method) {
                "userauthdetails" -> {
                    var flutterSideData: String = call.arguments as String
                    result.success("android")
                }

                "registerLogout" -> {

                    logoutResult = result;
                }

            }
        }
    }

    fun getVideoBitrate(videoUri: Uri?): Long {
        var bitrate: Long = 0
        val retriever = MediaMetadataRetriever()
        retriever.setDataSource(this, videoUri)
        val bitrateString: String? =
            retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_BITRATE)
        Log.d("mydebug getVideoBitrate ", "getVideoBitrate: $bitrateString")
        if (bitrateString != null) {
            bitrate = bitrateString.toLong()
        }
        retriever.release()
        return bitrate
    }


}


object TRCDataSingleton {

    private var token = ""

    private var authResponse: String? = null

    fun getXSerAuth() = token

    fun getAuthResponse() = authResponse

    fun setXUserAuth(tokenData: String?) {
        if ((tokenData != null) && tokenData.isNotEmpty()) {
            token = tokenData
        }
    }

}
