package `in`.cashify.androidtrc.common.api

import `in`.cashify.androidtrc.R
import `in`.reglobe.api.kotlin.callback.APICallback
import `in`.reglobe.api.kotlin.response.APIResponse
import `in`.reglobe.api.kotlin.service.APIService
import android.content.Context

class CasApiService<U, L : APIResponse>(override var api: Class<U>, val appContext: Context) : APIService<U, L>() {


    override fun execute(callback: APICallback<U, L>) {
        val headers = HashMap<String, String>()
        baseUrl = appContext.getString(R.string.base_auth_url)
        addHeaders(headers)
        super.execute(callback)
    }

}