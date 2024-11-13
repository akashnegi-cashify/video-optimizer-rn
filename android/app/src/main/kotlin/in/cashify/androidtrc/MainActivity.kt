package `in`.cashify.androidtrc


import android.media.MediaMetadataRetriever
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import com.example.video_compress.Utility
import com.otaliastudios.transcoder.Transcoder
import com.otaliastudios.transcoder.TranscoderListener
import com.otaliastudios.transcoder.source.UriDataSource
import com.otaliastudios.transcoder.strategy.DefaultAudioStrategy
import com.otaliastudios.transcoder.strategy.DefaultVideoStrategy
import com.otaliastudios.transcoder.strategy.RemoveTrackStrategy
import com.otaliastudios.transcoder.strategy.TrackStrategy
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterFragmentActivity
import java.io.File
import java.text.SimpleDateFormat
import java.util.Date
import java.util.concurrent.Future

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
    private var transcodeFuture: Future<Void>? = null

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

                "cancelCompression" -> {
                    transcodeFuture?.cancel(true)
                    result.success(false);
                }

                "compressVideo" -> {
                    val path = call.argument<String>("path")!!
                    val deleteOrigin = call.argument<Boolean>("deleteOrigin")!!

                    val includeAudio = call.argument<Boolean>("includeAudio") ?: true
                    val frameInterval: Int = call.argument<Int>("frameInterval") ?: 3
                    val setSpeed = call.argument<Double>("setSpeed") ?: 1.0
                    val frameRate =
                        if (call.argument<Int>("frameRate") == null) 30 else call.argument<Int>("frameRate")

                    val tempDir: String = getExternalFilesDir("video_compress")!!.absolutePath
                    val out = SimpleDateFormat("yyyy-MM-dd hh-mm-ss").format(Date())
                    val destPath: String =
                        tempDir + File.separator + "VID_" + out + path.hashCode() + ".mp4"

                    var currentBitrate = getVideoBitrate(Uri.parse(path))

                    var videoTrackStrategy: TrackStrategy =
                        DefaultVideoStrategy.atMost(340).build();
                    val audioTrackStrategy: TrackStrategy


                    videoTrackStrategy =
                        DefaultVideoStrategy.atMost(480, 640).bitRate(currentBitrate / 2)
                            .frameRate(frameRate!!)
                            .build()

                    audioTrackStrategy = if (includeAudio) {
                        val sampleRate = DefaultAudioStrategy.SAMPLE_RATE_AS_INPUT
                        val channels = DefaultAudioStrategy.CHANNELS_AS_INPUT

                        DefaultAudioStrategy.builder()
                            .channels(channels)
                            .sampleRate(sampleRate)
                            .build()
                    } else {
                        RemoveTrackStrategy()
                    }

                    val dataSource = UriDataSource(this, Uri.parse(path))
                    var context = this;

                    transcodeFuture = Transcoder.into(destPath)
                        .addDataSource(dataSource).setSpeed(setSpeed.toFloat())
                        .setAudioTrackStrategy(audioTrackStrategy)
                        .setVideoTrackStrategy(videoTrackStrategy)
                        .setListener(object : TranscoderListener {
                            override fun onTranscodeProgress(progress: Double) {
//                                channel.invokeMethod("updateProgress", progress * 100.00)
                            }

                            override fun onTranscodeCompleted(successCode: Int) {
//                                result.invokeMethod("updateProgress", 100.00)
                                val json =
                                    Utility("channelName").getMediaInfoJson(context, destPath)
                                json.put("isCancel", false)
                                result.success(json.toString())
                                if (deleteOrigin) {
                                    File(path).delete()
                                }
                            }

                            override fun onTranscodeCanceled() {
                                result.success(null)
                            }

                            override fun onTranscodeFailed(exception: Throwable) {
                                result.success(null)
                            }
                        }).transcode()
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
