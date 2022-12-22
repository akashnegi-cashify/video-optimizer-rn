package `in`.cashify.androidtrc.module.rubbing_engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class RubbingDeviceListResponse : BaseResponse() {

    @SerializedName("r_id" ) var rId : String?  = null
    @SerializedName("dt"   ) var dt  : RubbingListData? = RubbingListData()
    @SerializedName("s"    ) var s   : Boolean? = null

    }