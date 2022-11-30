package `in`.cashify.androidtrc.module.qc.data.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class SubmitQCResponse: BaseResponse() {
    @SerializedName("r_id")
   var r_id:String?=null

    @SerializedName("s")
    var success:Boolean?=null
}