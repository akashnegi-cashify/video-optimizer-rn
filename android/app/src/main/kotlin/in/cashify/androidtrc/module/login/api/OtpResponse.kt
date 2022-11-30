package `in`.cashify.androidtrc.module.login.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.text.TextUtils
import com.google.gson.annotations.SerializedName

class OtpResponse : BaseResponse() {
    @SerializedName("rid")
    var requestId: String? = null

    override fun isValid(condition: String?, isStrict: Boolean): Boolean {
        return !TextUtils.isEmpty(this.requestId)
    }
}