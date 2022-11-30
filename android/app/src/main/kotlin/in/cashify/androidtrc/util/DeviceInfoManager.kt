package `in`.reglobe.cashify.util

import `in`.cashify.androidtrc.util.PreferenceUtils
import android.content.Context
import android.os.Build
import android.text.TextUtils

/**
 * Created by Z50 on 08-Jan-16.
 * DeviceInfoManager
 */

object DeviceInfoManager {

    private val KEY_UNIQUE_DEVICE_ID = "unique_device_id"
@JvmStatic
    fun getUniqueDeviceId(context: Context?): String {
        return if (context == null) {
            ""
        } else return PreferenceUtils(context).getString(KEY_UNIQUE_DEVICE_ID, null).toString()
    }

    fun setUniqueDeviceId(context: Context?, deviceId: String) {
        if (context == null || TextUtils.isEmpty(deviceId)) {
            return
        }
        PreferenceUtils(context).putString(KEY_UNIQUE_DEVICE_ID, deviceId)
    }
}
