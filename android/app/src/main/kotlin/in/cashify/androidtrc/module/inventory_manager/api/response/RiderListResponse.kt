package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class RiderListResponse : BaseResponse(){
    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: ArrayList<Data>? = null




    class Data : BaseResponse() {


        @SerializedName("rn")
        var riderName: String? = null


        @SerializedName("rid")
        var riderId: Int? = null



    }
}