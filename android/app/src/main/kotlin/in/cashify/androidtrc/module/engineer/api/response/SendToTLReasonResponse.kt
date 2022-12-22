package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class SendToTLReasonResponse : BaseResponse() {

    @SerializedName("dt")
    var map:HashMap<String,String>? = null


    @SerializedName("s")
    var success:Boolean? = null



    @SerializedName("r_id")
    var rid:String? = null









}