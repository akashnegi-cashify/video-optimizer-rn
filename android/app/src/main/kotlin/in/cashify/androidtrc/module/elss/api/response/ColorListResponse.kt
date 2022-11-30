package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class ColorListResponse : BaseResponse() {

    @SerializedName("s")
    var isSuccess: Boolean = false

    @SerializedName("em")
    var errorMsg: String? = null

    @SerializedName("dt")
    var list: ArrayList<String>? = null

}