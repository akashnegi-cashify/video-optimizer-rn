package `in`.cashify.androidtrc.module.login.data

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.JWTParser
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.login.api.LoginModuleApi
import `in`.cashify.androidtrc.module.login.api.PasswordLoginRequest
import `in`.cashify.androidtrc.module.login.api.PasswordLoginResponse
import `in`.cashify.androidtrc.module.login.api.UserDetailResponse
import `in`.reglobe.api.kotlin.exception.APIException
import `in`.reglobe.cashify.util.DeviceInfoManager
import android.text.TextUtils
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class LoginViewModelV2 @Inject constructor() : BaseViewModel() {

    val employeeId: MutableLiveData<String> = MutableLiveData()
    val passwordEntered: MutableLiveData<String> = MutableLiveData()
    val errorNumber: MutableLiveData<String>? = MutableLiveData()
    var isClickable: MutableLiveData<Boolean>? = MutableLiveData()
    var loginProcessListener: LoginProcessListener? = null
    val location:MutableLiveData<String> = MutableLiveData()

    fun clickContinue() {
        if (TextUtils.isEmpty(employeeId.value.toString())) {
            return
        }
        loginProcessListener?.performVerification()
    }

    fun clickLogin() {
        val password = passwordEntered.value.toString()
        if (TextUtils.isEmpty(password)) {
            activityListener?.showError(mResourceProvider.getString(R.string.plz_enter_pass))
            return
        }

        signInEmployeeId(employeeId.value.toString(), password)
    }


    private fun signInEmployeeId(employeeId: String, password: String ) {
        activityListener?.showLoading(true)
        val request = PasswordLoginRequest()
        request.employeeId = employeeId
        request.password = password
        request.did = DeviceInfoManager.getUniqueDeviceId(mResourceProvider.mContext)
        request.lc = location.value
        val service = UserModuleService<LoginModuleApi, PasswordLoginResponse>(
            LoginModuleApi::class.java,
            mResourceProvider.mContext
        )
        service.execute(object :
            SessionBaseAPICallback<LoginModuleApi, PasswordLoginResponse>(activityListener) {
            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onSuccess(response: PasswordLoginResponse, rawResponse: Response) {
                if (!response.success) {
                    activityListener?.showError(response.errorMsg)
                    return
                }
                AppInfoProvider.getInstance().saveUserAuth(response.tokenResponse?.accessToken!!)
                val payload = JWTParser.getPayload(AppInfoProvider.getInstance().userAuth.toString())
                val gson = Gson()
                val userDetailResponse =
                    gson.fromJson(payload.toString(), UserDetailResponse::class.java)
                loginProcessListener?.onCompleteLogin(userDetailResponse)
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: LoginModuleApi): Deferred<retrofit2.Response<PasswordLoginResponse>> {
                return api.loginWithPasswordAsync(
                    request
                )
            }
        })
    }

}