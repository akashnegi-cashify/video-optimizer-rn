package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class RecommendedPartResponse : BaseResponse() {

    @SerializedName("r_id")
    var rid: String? = null

    @SerializedName("s")
    var success: Boolean = false
    
    @SerializedName("dt")
    var data: Data? = null


    @Keep
    class Data : BaseResponse() {

        @SerializedName("pbr")
        var pbr: String? = null

    }

}