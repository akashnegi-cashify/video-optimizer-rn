package `in`.cashify.androidtrc.module.rider.data.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class RecievePartFromEngineerResponse:BaseResponse() {


    @SerializedName("r_id")
    var rid:String? = null


    @SerializedName("s")
    var success: Boolean? = null
}