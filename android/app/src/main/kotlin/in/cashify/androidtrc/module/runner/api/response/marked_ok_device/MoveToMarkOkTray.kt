package `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class MoveToMarkOkTray : BaseResponse() {
    @SerializedName("s")
    var isSuccess: Boolean = false
    @SerializedName("em")
    var errorMessage: String? = null
}