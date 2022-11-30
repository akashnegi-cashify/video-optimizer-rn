package `in`.cashify.androidtrc.module.runner.api.response.l4

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class MarkedL4PendingDeviceResponse : BaseResponse() {
    @SerializedName("dt")
    var deviceList: ArrayList<MarkedL4PendingDeviceInfo>? = null
}