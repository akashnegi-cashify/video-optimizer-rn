package `in`.cashify.androidtrc.common.api

import com.google.gson.annotations.SerializedName

class ActionResponse(actionType: String, actionData: Map<String, String>) : BaseResponse() {

    @SerializedName("at")
    var actionType: String? = actionType
    @SerializedName("ad")
    var actionData: Map<String, String>? = actionData

}
