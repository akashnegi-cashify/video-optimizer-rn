package `in`.cashify.androidtrc.module.login.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 16,January,2020
 */
class PasswordLoginResponse : BaseResponse() {

    @SerializedName("r_id")
    var requestId: String? = null
    @SerializedName("dt")
    var tokenResponse: TokenResponse? = null
    @SerializedName("s")
    var success: Boolean = false
    @SerializedName("em")
    var errorMsg: String? = null

}