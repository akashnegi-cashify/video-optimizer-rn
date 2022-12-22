package `in`.cashify.androidtrc.util

import android.view.Gravity
import de.keyboardsurfer.android.widget.crouton.Style

/**
 * Created by Z50 on 21-May-16.
 * TrcAlertStyle
 */
object TrcAlertStyle {

    val holoRedLight = -0x2eb7ca
    val holoGreenLight = -0xe9589b
    val holoBlueLight = -0x3e8058

    /**
     * Default style for alerting the user.
     */
    val ERROR: Style
    /**
     * Default style for alerting the user.
     */
    val ERROR_TOP: Style
    /**
     * Default style for confirming an action.
     */
    val SUCCESS: Style
    /**
     * Default style for general information.
     */
    val PROMPT: Style

    init {
        ERROR = Style.Builder()
            .setBackgroundColorValue(holoRedLight)
            .build()
        ERROR_TOP = Style.Builder()
            .setBackgroundColorValue(holoRedLight)
            .setGravity(Gravity.TOP or Gravity.CENTER_HORIZONTAL)
            .build()
        SUCCESS = Style.Builder()
            .setBackgroundColorValue(holoGreenLight)
            .build()
        PROMPT = Style.Builder()
            .setBackgroundColorValue(holoBlueLight)
            .build()
    }

}
