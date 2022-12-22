package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 27,August,2019
 */
open class EngBaseResponse : BaseResponse() {
    @SerializedName("em")
    var errorMsg: String? = null
    @SerializedName("s")
    var isSuccess: Boolean = false
}