package `in`.cashify.androidtrc.module.login.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 16,January,2020
 */
class TokenResponse : BaseResponse() {

    @SerializedName("token")
    var accessToken: String? = null

}