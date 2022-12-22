package `in`.cashify.androidtrc.module.runner.api.response.device_list

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class DeviceListAllocatedToEng : BaseResponse() {
    @SerializedName("dt")
     var deviceList: ArrayList<DeviceInfoAllocatedToEng>? = null
}