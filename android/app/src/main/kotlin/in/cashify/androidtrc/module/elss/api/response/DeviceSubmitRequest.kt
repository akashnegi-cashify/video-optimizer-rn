package `in`.cashify.androidtrc.module.elss.api.response

import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName


@Keep
class DeviceSubmitRequest {
    @SerializedName("dbr")
    var deviceBarcode: String? = null


    @SerializedName("cl")
    var color: String? = null

    @SerializedName("bid")
    var brandId: Int? = null

    @SerializedName("pid")
    var productId: Int? = null


}