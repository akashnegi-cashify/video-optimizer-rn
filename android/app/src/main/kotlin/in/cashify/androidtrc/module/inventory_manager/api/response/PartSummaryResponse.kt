package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class PartSummaryResponse : BaseResponse() {



        @SerializedName("r_id")
        var reqId:String = ""


    @SerializedName("s")
    var success = false


    @SerializedName("dt")
    var data:Data? = null



    @Keep
    class Data:BaseResponse(){
        @SerializedName("ac")
        var assignedCount = 0

        @SerializedName("pdc")
        var pendingDeliveriCount = 0


    }

}