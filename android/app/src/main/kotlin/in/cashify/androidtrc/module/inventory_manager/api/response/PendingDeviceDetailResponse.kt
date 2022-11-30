package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class PendingDeviceDetailResponse:BaseResponse() {

    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: Data? = null


    class Data : BaseResponse() {

        @SerializedName("did")
        var did:Int? = null

        @SerializedName("pt")
        var pt:String? =null

        @SerializedName("dbr")
        var dbr:String? =  null


        @SerializedName("st")
        var st:String? = null

        @SerializedName("en")
        var en:String? = null


        @SerializedName("rt")
        var repairType:String? = null

        @SerializedName("gr")
        var grade:String? = null


        @SerializedName("lc")
        var lc:String? = null


    }


}