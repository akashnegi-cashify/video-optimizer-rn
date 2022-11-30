package `in`.cashify.androidtrc.module.inventory_manager.api.request

import `in`.cashify.androidtrc.common.api.BaseRequest
import com.google.gson.annotations.SerializedName

class RiderAssignRequest : BaseRequest() {
    @SerializedName("rid")
    var riderId:Int? = null

    @SerializedName("dList")
    var dataList:ArrayList<Int>? = null

}