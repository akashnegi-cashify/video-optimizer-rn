package `in`.cashify.androidtrc.common

import `in`.cashify.androidtrc.common.api.APIConstant
import `in`.cashify.androidtrc.module.login.api.UserDetailResponse
import `in`.cashify.androidtrc.util.CommonConstant
import `in`.cashify.androidtrc.util.PreferenceUtils
import android.text.TextUtils
import com.google.gson.Gson


class AppInfoProvider private constructor() {

    private var preferenceUtils: PreferenceUtils? = null

    companion object {

        private val mInstance = AppInfoProvider()

        @Synchronized
        fun getInstance(): AppInfoProvider {
            return mInstance
        }
    }

    fun init(preference: PreferenceUtils) {
        this@AppInfoProvider.preferenceUtils = preference
    }

    val isUserLogin: Boolean
        get() = preferenceUtils?.getString(APIConstant.KEY_USER_AUTH) != null

    val userAuth: String?
        get() = preferenceUtils?.getString(APIConstant.KEY_USER_AUTH)

    val userEmail: String?
        get() = preferenceUtils?.getString(CommonConstant.KEY_EMAIL_ID)

    val userMobile: String?
        get() = preferenceUtils?.getString(CommonConstant.KEY_USER_MOBILE)

    val userProfilePicUrl: String?
        get() = preferenceUtils?.getString(CommonConstant.KEY_IMAGE_URL)

    fun saveUserName(name: String?) {
        if (name == null || name.isEmpty()) {
            return
        }
        preferenceUtils?.putString(CommonConstant.KEY_USER_NAME, name)
    }

    fun saveUserAuth(auth: String) {
        if (TextUtils.isEmpty(auth)) {
            return
        }
        preferenceUtils?.putString(APIConstant.KEY_USER_AUTH, auth)
    }

    private fun saveEmail(email: String?) {
        if (email == null || email.isEmpty()) {
            return
        }
        preferenceUtils?.putString(CommonConstant.KEY_EMAIL_ID, email)

    }

    fun saveMobileNumber(mobileNum: String?) {
        if (mobileNum == null || mobileNum.isEmpty()) {
            return
        }
        preferenceUtils?.putString(CommonConstant.KEY_USER_MOBILE, mobileNum)

    }

    fun destroySession() {
        preferenceUtils?.putString(APIConstant.KEY_USER_AUTH, null)
        removeUserDetailResponse()
    }

    fun getUserDetailResponse(): UserDetailResponse? {
        val response = preferenceUtils?.getString(CommonConstant.USER_DETAIL_RESPONSE)
        if (!TextUtils.isEmpty(response)) {
            val gson = Gson()
            return gson.fromJson(response, UserDetailResponse::class.java)
        }
        return null
    }

    fun setUserDetailResponse(response: UserDetailResponse?) {
        if (response == null) {
            return
        }
        val gson = Gson()
        val data = gson.toJson(response)
        preferenceUtils?.putString(CommonConstant.USER_DETAIL_RESPONSE, data)
    }

    fun removeUserDetailResponse() {
        preferenceUtils?.putString(CommonConstant.USER_DETAIL_RESPONSE, null)
    }

    fun getUserName(): String? {
        return if (getUserDetailResponse() != null) {
            getUserDetailResponse()!!.userName
        } else ""
    }

}
