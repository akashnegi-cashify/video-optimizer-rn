package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 26,July,2019
 */
class EngineerDeviceList : BaseResponse() {
    @SerializedName("dt")
    var deviceList: ArrayList<EngineerDeviceInfo>? = null
    var isSuccess: Boolean = false
}