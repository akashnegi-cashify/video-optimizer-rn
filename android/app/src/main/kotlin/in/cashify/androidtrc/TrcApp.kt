package `in`.cashify.androidtrc

import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.dagger.AppComponent
import `in`.cashify.androidtrc.common.dagger.DaggerAppComponent
import android.content.Context
import android.os.StrictMode
import android.util.Log
import com.google.firebase.FirebaseApp

import dagger.android.AndroidInjector
import dagger.android.support.DaggerApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import java.lang.ref.WeakReference


/**
 * Created by Avaneesh Maurya on 19,July,2019
 */

class TrcApp : DaggerApplication() {


    override fun applicationInjector(): AndroidInjector<DaggerApplication> {

        val appComponent = DaggerAppComponent.builder().application(this).build()
        val preferenceUtils = appComponent.injectSharedPref()
        AppInfoProvider.getInstance().init(preferenceUtils)

        Log.e("TRC app dagger data", appComponent.toString())
        appComponent.inject(this)
        FirebaseApp.initializeApp(this)
        return appComponent
    }


    override fun onCreate() {

        super.onCreate()
        context = WeakReference(applicationContext)
        val builder = StrictMode.VmPolicy.Builder()
        StrictMode.setVmPolicy(builder.build())
        builder.detectFileUriExposure()
    }

    companion object {
        private var context: WeakReference<Context>? = null

        @JvmStatic
        val appContext: Context?
            get() = context!!.get()

    }
}

