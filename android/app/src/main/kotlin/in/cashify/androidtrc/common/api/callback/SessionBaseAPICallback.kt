package `in`.cashify.androidtrc.common.api.callback

import `in`.cashify.androidtrc.common.ActivityListener
import `in`.reglobe.api.kotlin.callback.APICallback
import `in`.reglobe.api.kotlin.exception.APIException
import `in`.reglobe.api.kotlin.exception.ApiErrorCode
import `in`.reglobe.api.kotlin.response.APIResponse

abstract class SessionBaseAPICallback<U, T : APIResponse>(val activityListener: ActivityListener?) :
    APICallback<U, T>() {

    override fun onFailure(e: APIException) {
        val errorCode = e.code

        when (errorCode) {
            ApiErrorCode.UNAUTHORIZE_ACCESS
                , ApiErrorCode.USER_SESSION_EXPIRE -> onSessionExpire()

            else -> onFail(e)
        }
    }

    protected fun onSessionExpire() {
        activityListener?.sessionExpire()
    }

    abstract fun onFail(e: APIException)

}