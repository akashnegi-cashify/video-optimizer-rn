package `in`.cashify.androidtrc.module.rubbing_engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class RubbingDeviceReceiveResponse : BaseResponse() {

    @SerializedName("s")
    var isSuccess: Boolean = false

    @SerializedName("sm")
    var successMsg: String? = null

    @SerializedName("em")
    var errorMsg: String? = null

}