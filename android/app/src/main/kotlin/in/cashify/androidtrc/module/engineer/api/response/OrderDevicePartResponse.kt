package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 21,August,2019
 */
class OrderDevicePartResponse : BaseResponse() {
    @SerializedName("s")
    var isSuccess: Boolean = false
}