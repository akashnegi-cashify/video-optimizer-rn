package `in`.cashify.androidtrc.util

import `in`.reglobe.cashify.module.AdvertiseIdGenerateListener
import `in`.reglobe.cashify.util.DeviceInfoManager
import android.content.Context
import android.os.AsyncTask
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import java.lang.ref.WeakReference

class AdvertiseIdGenerator(context: Context, private val listener: AdvertiseIdGenerateListener?) :
    AsyncTask<Void, Void, String>() {
    private val context: WeakReference<Context>?

    init {

        this.context = WeakReference(context)
    }

    override fun doInBackground(vararg params: Void): String? {
        var advertId: String? = null
        val idInfo: AdvertisingIdClient.Info?
        try {
            if (context == null) {
                return null
            }
            idInfo = context.get()?.let { AdvertisingIdClient.getAdvertisingIdInfo(it) }
            if (idInfo != null) {
                advertId = idInfo.id
                DeviceInfoManager.setUniqueDeviceId(context.get(), advertId.toString())

            }
        } catch (ignored: Exception) {
        }

        return advertId
    }

    override fun onPostExecute(advertId: String?) {
        if (advertId == null) {
            return
        }
        listener?.onDeviceIdGenerate(advertId)
    }
}