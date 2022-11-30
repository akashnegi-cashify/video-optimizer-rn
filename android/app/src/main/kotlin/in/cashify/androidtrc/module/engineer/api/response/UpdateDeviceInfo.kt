package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 26,July,2019
 */
class UpdateDeviceInfo : BaseResponse() {

    @SerializedName("did")
    var deviceId: String? = null
    @SerializedName("pt")
    var productTitle: String? = null
    @SerializedName("dbr")
    var deviceBarcode: String? = null
    @SerializedName("st")
    var status: String? = null
}

