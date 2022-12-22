package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

class GroupListResponse : BaseResponse() {


    @SerializedName("r_id")
    var rid:String? = ""



    @SerializedName("s")
    var success:Boolean? = null



    @SerializedName("dt")
   var groupList:List<String>? = null
}