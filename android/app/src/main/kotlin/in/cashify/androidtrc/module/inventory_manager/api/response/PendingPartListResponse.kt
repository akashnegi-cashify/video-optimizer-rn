package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import com.google.gson.annotations.SerializedName

class PendingPartListResponse  : BaseResponse() {

    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: ArrayList<Data>? = null


    @SerializedName("s")
   var  status: Boolean? = null


    class Data : BaseResponse() {

        @SerializedName("sku")
        var sku:String? = null

        @SerializedName("pn")
        var pn:String? =null

        @SerializedName("st")
        var st:String? =  null


        @SerializedName("prid")
        var prid:Int? = null


        @SerializedName("stc")
        var statusCode:Int? = null

        @SerializedName("prdt")
        var requestedTime:Long = 0




        fun getPartStatus():PartStatus {
            if(statusCode == 12){
                return PartStatus.AVAILABBLE
            }
            else   if(statusCode == 13){
                return PartStatus.NOT_AVAILABLE
            }


            else{
                return PartStatus.OTHER
            }

        }





    }











}