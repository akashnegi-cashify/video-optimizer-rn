package `in`.cashify.androidtrc

import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.FlutterData
import `in`.cashify.androidtrc.common.JWTParser
import `in`.cashify.androidtrc.common.dagger.AppComponent
import `in`.cashify.androidtrc.module.login.api.UserDetailResponse
import `in`.cashify.androidtrc.module.runner.HomeActivity
import `in`.cashify.androidtrc.util.AppUtils
import `in`.cashify.common_uploader.utils.PreferenceUtils
import `in`.reglobe.api.kotlin.auth.AuthResponse
import android.content.Intent
import android.os.Bundle
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.startActivity
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.HashMap
import javax.inject.Inject

class MainActivity : FlutterActivity() {

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
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("mydebug----", "onCreate: ")

    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d("mydebug----", "onNewIntent: ")
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine);



        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        ).setMethodCallHandler { call, result ->
            println("MainActivity--- CHANNEL = ${CHANNEL},METHOD NAME ${call.method}")
            when (call.method) {
                "userauthdetails" -> {
                    var flutterSideData: String = call.arguments as String

                    val authDataObj: FlutterData =
                        Gson().fromJson(flutterSideData, FlutterData::class.java)

                    if (authDataObj.authData != null) {

                        AppInfoProvider.getInstance()
                            .saveAuthResponse(Gson().toJson(authDataObj.authData))
                    }


                    if (authDataObj.token != null && !TextUtils.isEmpty(authDataObj.token)) {


                        TRCDataSingleton.setXUserAuth(authDataObj.token)
                        AppInfoProvider.getInstance().saveUserAuth(authDataObj.token!!)
                        val payload = JWTParser.getPayload(authDataObj.token.toString())
                        val gson = Gson()
                        val userDetailResponse =
                            gson.fromJson(payload.toString(), UserDetailResponse::class.java)

                        AppInfoProvider.getInstance().setUserDetailResponse(userDetailResponse)
                        startActivity(Intent(this, HomeActivity::class.java))
                        // finish()
                    }
                    result.success("android")
                }
                "registerLogout" -> {

                    logoutResult = result;
                }
            }


        }
    }
}


object TRCDataSingleton {

    private var token = ""

    private var authResponse: AuthResponse? = null

    fun getXSerAuth() = token

    fun getAuthResponse() = authResponse

    fun setXUserAuth(tokenData: String?) {
        if ((tokenData != null) && tokenData.isNotEmpty()) {
            token = tokenData
        }
    }

}
