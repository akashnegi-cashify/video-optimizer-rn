package `in`.cashify.androidtrc.module.rubbing_engineer.api.request

import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName


@Keep
class RubbingDeviceListRequest {
    @SerializedName("pno" ) var pageNo : Int? = null
    @SerializedName("ln"  ) var pageSize  : Int? = null
    @SerializedName("fp"  ) var searcQuery :SearchQuery?=null


}