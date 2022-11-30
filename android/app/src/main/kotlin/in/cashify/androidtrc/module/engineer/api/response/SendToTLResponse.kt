package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class SendToTLResponse:BaseResponse() {

    @SerializedName("r_id")
    var rid:String? = null



    @SerializedName("s")
    var s:Boolean? = null



    @SerializedName("em")
    var message:String? = null
}