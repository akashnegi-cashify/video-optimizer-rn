package `in`.cashify.androidtrc.module.rubbing_engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class RubbingListData : BaseResponse() {
    @SerializedName("tp" ) var tp : Int?          = null
    @SerializedName("tr" ) var tr : Int?          = null
    @SerializedName("dl" ) var dataList : ArrayList<RubbingDeviceData> = arrayListOf()
    }