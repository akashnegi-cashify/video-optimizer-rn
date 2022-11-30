package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 31,Agosto,2019
 */
class ReturnPartData : BaseResponse() {
    @SerializedName("pbr")
    var partBarcode: String? = null
    @SerializedName("pid")
    var partId: String? = null
    @SerializedName("rr")
    var returnReason: String? = null
    @SerializedName("remark")
    var remark: String? = null
    @SerializedName("prid")
    var prid:Int? = null
}