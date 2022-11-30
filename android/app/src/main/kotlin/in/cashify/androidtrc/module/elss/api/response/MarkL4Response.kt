package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class MarkL4Response : BaseResponse() {
    @SerializedName("did")
    var deviceId: Int? = null
    @SerializedName("pt")
    var productTitle: String? = null
    @SerializedName("dbr")
    var deviceBarcode: String? = null
    @SerializedName("st")
    var status: String? = null
    @SerializedName("s")
    var isSuccess: Boolean = false
    @SerializedName("em")
    var errorMsg: String? = null

}