package `in`.cashify.androidtrc.module.rider.data.request

import `in`.cashify.androidtrc.common.api.BaseRequest
import com.google.gson.annotations.SerializedName

class ListReceivePartsFromIMRequest:BaseRequest() {

    @SerializedName("pno")
    var pageNo:Int? = null


    @SerializedName("ln")
    var listNo:Int? = null


    @SerializedName("br")
    var barcode:String? = null


    var fp :FacilityPart? =null



    class FacilityPart:BaseRequest(){
        var is_urgent = false
    }
}