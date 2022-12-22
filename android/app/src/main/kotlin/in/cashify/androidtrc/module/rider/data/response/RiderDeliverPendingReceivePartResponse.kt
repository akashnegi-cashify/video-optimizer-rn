package `in`.cashify.androidtrc.module.rider.data.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class RiderDeliverPendingReceivePartResponse : BaseResponse() {


    @SerializedName("r_id")
    var rid:String? = null



    @SerializedName("dt")
    var data: ArrayList<Data>? = null



    @SerializedName("s")
    var success: Boolean? = null



    class Data:BaseResponse(){
        @SerializedName("pn")
        var partName: String? = null
        @SerializedName("pbr")
        var partBarcode: String? = null
        @SerializedName("sku")
        var partSku: String? = null



        @SerializedName("dna")
        var deviceName: String? = null

        @SerializedName("pc")
        var partColor: String? = null



        @SerializedName("dbr")
        var deviceBarcode: String? = null



        @SerializedName("prid")
        var partId: Int? = null


        @SerializedName("isBulk")
        var isBulk: Boolean? = null


    }}