package `in`.cashify.androidtrc

import android.app.Application
import android.content.Context
import android.os.StrictMode
import com.facebook.react.PackageList
import com.facebook.react.ReactApplication
import com.facebook.react.ReactHost
import com.facebook.react.ReactNativeApplicationEntryPoint.loadReactNative
import com.facebook.react.ReactPackage
import com.facebook.react.defaults.DefaultReactHost.getDefaultReactHost
import `in`.cashify.androidtrc.flutter.CopsFlutterPackage
import java.lang.ref.WeakReference

/**
 * RN host Application class. Replaces the original [TrcApp] from the pure-Flutter project.
 *
 * Responsibilities:
 *  - Initialize React Native (loadReactNative + reactHost)
 *  - Preserve the StrictMode VmPolicy + WeakReference context singleton from TrcApp.
 *
 * NOTE: We do NOT pre-warm a FlutterEngine here. ActivityAware plugins
 * (flutter_local_notifications, image_picker, local_auth, permission_handler, ...)
 * need an attached Activity, and a cached engine runs Dart before any Activity exists.
 * Each CopsFlutterActivity owns its own engine — see CopsFlutterActivity.kt.
 */
class CopsApp : Application(), ReactApplication {

  override val reactHost: ReactHost by lazy {
    getDefaultReactHost(
      context = applicationContext,
      packageList = (PackageList(this).packages + extraPackages).toMutableList(),
    )
  }

  private val extraPackages: List<ReactPackage> = listOf(CopsFlutterPackage())

  override fun onCreate() {
    super.onCreate()

    // Preserve TrcApp behavior: weak global app-context handle + StrictMode setup.
    appContextRef = WeakReference(applicationContext)
    val builder = StrictMode.VmPolicy.Builder()
    StrictMode.setVmPolicy(builder.build())
    builder.detectFileUriExposure()

    loadReactNative(this)
  }

  companion object {
    private var appContextRef: WeakReference<Context>? = null

    @JvmStatic
    val appContext: Context?
      get() = appContextRef?.get()
  }
}
