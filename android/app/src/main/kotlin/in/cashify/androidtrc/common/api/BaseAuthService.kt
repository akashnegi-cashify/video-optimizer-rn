package `in`.cashify.androidtrc.common.api

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.TrcApp
import `in`.reglobe.api.kotlin.callback.APICallback
import `in`.reglobe.api.kotlin.response.APIResponse
import `in`.reglobe.api.kotlin.service.AuthAPIService
import `in`.reglobe.api.kotlin.service.AuthRequestData
import android.content.Context
import androidx.annotation.Keep
import com.chuckerteam.chucker.api.ChuckerInterceptor

@Keep
abstract class BaseAuthService<U, L : APIResponse>(private val appContext: Context) : AuthAPIService<U, L>() {

    init {
        addInterceptor(ChuckerInterceptor(appContext))
    }

    override var context: Context
        get() = appContext
        set(value) {}

    override val authRequestData: AuthRequestData
        get() = AuthRequestData(
            context.getString(R.string.base_auth_url),
            context.getString(R.string.end_auth_url),
            context.getString(R.string.auth_api_url),
            serviceGroup, serviceIdentifier
        )

    override fun execute(callback: APICallback<U, L>) {
        val headers = HashMap<String, String>()
        addHeaders(headers)
        super.execute(callback)
    }


    protected val serviceIdentifier: String?
        get() = null

    protected abstract var serviceGroup: String

}