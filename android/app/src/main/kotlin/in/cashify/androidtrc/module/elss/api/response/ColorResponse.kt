package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class ColorResponse() : BaseResponse(), Parcelable {
    @SerializedName("s")
    var isSuccess: Boolean = false
    @SerializedName("em")
    var errorMsg: String? = null

    constructor(parcel: Parcel) : this() {
        isSuccess = parcel.readByte() != 0.toByte()
        errorMsg = parcel.readString()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeByte(if (isSuccess) 1 else 0)
        parcel.writeString(errorMsg)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<BrandResponse> {
        override fun createFromParcel(parcel: Parcel): BrandResponse {
            return BrandResponse(parcel)
        }

        override fun newArray(size: Int): Array<BrandResponse?> {
            return arrayOfNulls(size)
        }
    }


}