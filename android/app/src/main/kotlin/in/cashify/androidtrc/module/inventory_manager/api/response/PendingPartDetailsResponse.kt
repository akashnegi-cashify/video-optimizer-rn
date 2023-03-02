package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class PendingPartDetailsResponse:BaseResponse() {


    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: Data? = null


    @Keep
    class Data : BaseResponse() {



        @SerializedName("sku")
        var sku:String? = null


        @SerializedName("pn")
        var partName:String? = null

        @SerializedName("pc")
        var partColor:String? =null

        @SerializedName("st")
        var status:String? =  null


        @SerializedName("apn")
        var apn:String? = null

        @SerializedName("asku")
        var asku:String? = null






        @SerializedName("apc")
        var apc:String? = null



        @SerializedName("ast")
        var ast:String? = null




        @SerializedName("rqty")
        var requestQuantity:String? = null



        @SerializedName("pbr")
        var pbr:String? = null


    }


}