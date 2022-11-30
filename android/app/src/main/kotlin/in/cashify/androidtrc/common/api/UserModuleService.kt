package `in`.cashify.androidtrc.common.api

import `in`.reglobe.api.kotlin.callback.APICallback
import `in`.reglobe.api.kotlin.response.APIResponse
import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.reglobe.api.kotlin.util.Defaults
import android.content.Context
import android.text.TextUtils
import android.util.Log

class UserModuleService<U, L : APIResponse>(val apiClass: Class<U>, appContext: Context) : BaseAuthService<U, L>(appContext)
{

    override fun execute(callback: APICallback<U, L>)
    {
        if (!TextUtils.isEmpty(AppInfoProvider.getInstance().userAuth))
        {
            val headerValue = AppInfoProvider.getInstance().userAuth!!
            addHeader(APIConstant.KEY_USER_AUTH, headerValue)
            Log.d(Defaults.TAG, " : X-USER-AUTH $headerValue")
        }
        super.execute(callback)
    }

    override var serviceGroup: String
        get() = APIConstant.SERVICE_NAME
        set(value) {}

    override var api: Class<U>
        get() = apiClass
        set(value) {}


}