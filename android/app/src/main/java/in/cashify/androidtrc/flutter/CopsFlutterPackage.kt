package `in`.cashify.androidtrc.flutter

import android.view.View
import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ReactShadowNode
import com.facebook.react.uimanager.ViewManager

/**
 * Registers [CopsFlutterModule] with React Native.
 *
 * Added in [`in.cashify.androidtrc.CopsApp.extraPackages`] (not autolinked since it lives
 * inside the host app, not in a separate npm package).
 */
class CopsFlutterPackage : ReactPackage {
  override fun createNativeModules(reactContext: ReactApplicationContext): MutableList<NativeModule> =
    mutableListOf(
      CopsFlutterModule(reactContext),
      RnLeafModule(reactContext),
    )

  override fun createViewManagers(
    reactContext: ReactApplicationContext
  ): MutableList<ViewManager<View, ReactShadowNode<*>>> = mutableListOf()
}
