package `in`.cashify.androidtrc

import android.content.Intent
import android.os.Bundle
import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.fabricEnabled
import com.facebook.react.defaults.DefaultReactActivityDelegate
import `in`.cashify.androidtrc.flutter.CopsFlutterActivity

/**
 * RN launcher activity.
 *
 * In Phase 1 the RN host is a thin shell: it immediately starts [CopsFlutterActivity]
 * and finishes itself so the user back-stack contains only Flutter. When the user
 * presses back from Flutter's root, the app goes to the home screen (correct behavior).
 *
 * This activity's React JS code still runs (App.tsx) and is responsible for invoking
 * the bridge method [CopsFlutterModule.launchFlutter] in case a future RN screen ever
 * needs to re-enter Flutter mid-session.
 */
class MainActivity : ReactActivity() {

  override fun getMainComponentName(): String = "CashifyOps"

  override fun createReactActivityDelegate(): ReactActivityDelegate =
      DefaultReactActivityDelegate(this, mainComponentName, fabricEnabled)

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    // Immediately jump to Flutter. The RN view never renders to the user.
    val intent = Intent(this, CopsFlutterActivity::class.java).apply {
      flags = Intent.FLAG_ACTIVITY_NO_ANIMATION
    }
    startActivity(intent)
    overridePendingTransition(0, 0)
    finish()
  }
}
