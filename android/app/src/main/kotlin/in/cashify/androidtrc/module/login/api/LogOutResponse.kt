package `in`.cashify.androidtrc.module.login.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 21,January,2020
 */
class LogOutResponse : BaseResponse() {

    @SerializedName("s")
    var success: Boolean = false
    @SerializedName("em")
    var errorMsg: String? = null
}