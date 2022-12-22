package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
class SubmitElssResponse : BaseResponse() {
    @SerializedName("s")
    var isSuccess: Boolean = false
    @SerializedName("em")
    var errorMsg: String? = null
    @SerializedName("sm")
    var alertMsg: String? = null
   }