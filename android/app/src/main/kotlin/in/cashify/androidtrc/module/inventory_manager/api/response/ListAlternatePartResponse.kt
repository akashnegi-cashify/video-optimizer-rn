package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class ListAlternatePartResponse:BaseResponse() {



    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: ArrayList<Data>? = null


    @SerializedName("s")
    var  status: Boolean? = null


    @Keep
    class Data : BaseResponse() {

        @SerializedName("sku")
        var sku:String? = null

        @SerializedName("pn")
        var pn:String? =null





    }
}