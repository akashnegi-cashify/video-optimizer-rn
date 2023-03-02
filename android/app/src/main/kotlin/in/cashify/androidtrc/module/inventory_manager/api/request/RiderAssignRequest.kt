package `in`.cashify.androidtrc.module.inventory_manager.api.request

import `in`.cashify.androidtrc.common.api.BaseRequest
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class RiderAssignRequest : BaseRequest() {
    @SerializedName("rid")
    var riderId:Int? = null

    @SerializedName("dList")
    var dataList:ArrayList<Int>? = null

}