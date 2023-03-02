package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class InitiateAlternatePartResponse:BaseResponse() {
    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: Data? = null


    @SerializedName("s")
    var  status: Boolean? = null


    class Data : BaseResponse() {

        @SerializedName("prid")
        var prid:Int? = null







    }
}