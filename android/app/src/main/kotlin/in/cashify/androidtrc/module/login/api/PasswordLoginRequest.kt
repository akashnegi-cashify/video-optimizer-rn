package `in`.cashify.androidtrc.module.login.api

import `in`.cashify.androidtrc.common.api.BaseRequest
import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 16,January,2020
 */
class PasswordLoginRequest : BaseRequest()
{
    @SerializedName("empCo")
    var employeeId: String? = null
    @SerializedName("ps")
    var password: String? = null
    @SerializedName("did")
    var did: String? = null
    @SerializedName("gcm")
    var gcm: String? = null


    @SerializedName("lc")
    var lc: String? = null

}