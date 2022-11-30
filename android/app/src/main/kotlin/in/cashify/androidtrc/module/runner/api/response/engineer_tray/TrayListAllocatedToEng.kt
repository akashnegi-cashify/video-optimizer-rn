package `in`.cashify.androidtrc.module.runner.api.response.engineer_tray

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class TrayListAllocatedToEng : BaseResponse() {
    @SerializedName("dt")
    var trayList: ArrayList<TrayInfoAllocatedToEng>? = null
}