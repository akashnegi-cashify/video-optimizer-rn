package `in`.cashify.androidtrc.module.rider.data.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class ReceiveEngineerListResponse : BaseResponse() {


    @SerializedName("r_id")
    var rid:String? = null



    @SerializedName("dt")
    var data: ArrayList<Data>? = null



    class Data: BaseResponse() {
        @SerializedName("id")
        var id:Int? = null


        @SerializedName("n")
        var name:String? = null



        @SerializedName("lc")
        var location:String? = null

    }
}