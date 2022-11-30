package `in`.cashify.androidtrc.module.rubbing_engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class RubbingDeviceData : BaseResponse() {

    @SerializedName("did" ) var deviceId : Int?    = null
    @SerializedName("pt"  ) var productTitle  : String? = null
    @SerializedName("dbr" ) var deviceBarcode : String? = null
    @SerializedName("tbr" ) var trayBarcode : String? = null

}