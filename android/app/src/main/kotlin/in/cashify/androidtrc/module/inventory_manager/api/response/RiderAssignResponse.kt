package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class RiderAssignResponse : BaseResponse(){
    @SerializedName("r_id")
    var rid:String? = null
    @SerializedName("s")
    var success:Boolean? = null
}