package `in`.cashify.androidtrc

import android.os.Bundle
import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.fabricEnabled
import com.facebook.react.defaults.DefaultReactActivityDelegate
import `in`.cashify.androidtrc.flutter.CopsRnLeafBridge

/**
 * RN leaf host. Launched by [CopsRnLeafBridge] from inside Flutter to render a single RN
 * sub-flow (e.g. the RMS module).
 *
 * The JS component registered as "RnLeafApp" receives `route` and `paramsJson` as initial
 * props (see [CopsRnLeafBridge.buildLaunchOptions]). When the RN flow is done it calls
 * `RnLeaf.finishLeaf()` (see RnLeafModule) which invokes [finish] and returns to Flutter.
 *
 * Unlike [MainActivity], this activity is **not** the launcher — it is started on demand and
 * sits on top of the Flutter activity in the back stack. Pressing back from the root RN
 * screen returns to Flutter.
 */
class RnLeafActivity : ReactActivity() {

  override fun getMainComponentName(): String = COMPONENT_NAME

  override fun createReactActivityDelegate(): ReactActivityDelegate =
    object : DefaultReactActivityDelegate(this, mainComponentName, fabricEnabled) {
      override fun getLaunchOptions(): Bundle = CopsRnLeafBridge.buildLaunchOptions(intent)
    }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
  }

  companion object {
    const val COMPONENT_NAME = "RnLeafApp"
  }
}
