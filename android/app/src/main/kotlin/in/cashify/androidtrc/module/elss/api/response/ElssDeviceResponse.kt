package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class ElssDeviceResponse() : BaseResponse(), Parcelable {
    @SerializedName("dt")
    var elssDeviceDetail: ElssDeviceDetail? = null

    @SerializedName("s")
    var isSuccess: Boolean = false

    @SerializedName("em")
    var errorMsg: String? = null

    constructor(parcel: Parcel) : this() {
        elssDeviceDetail =
            parcel.readParcelable(ElssDeviceDetail::class.java.classLoader)
        isSuccess = parcel.readByte() != 0.toByte()
        errorMsg = parcel.readString()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeParcelable(elssDeviceDetail, flags)
        parcel.writeByte(if (isSuccess) 1 else 0)
        parcel.writeString(errorMsg)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ElssDeviceResponse> {
        override fun createFromParcel(parcel: Parcel): ElssDeviceResponse {
            return ElssDeviceResponse(parcel)
        }

        override fun newArray(size: Int): Array<ElssDeviceResponse?> {
            return arrayOfNulls(size)
        }
    }


}