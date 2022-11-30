package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


class DeviceDetailSubmitResponse : BaseResponse() {

    @SerializedName("s")
    var success: Boolean = false
    @SerializedName("em")
    var errorMsg: String? = null
}