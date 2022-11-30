package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 14/10/20.
 */
class CancelPartResponse() : BaseResponse() , Parcelable{
    @SerializedName("r_id")
    var requestId: String? = null
    @SerializedName("s")
    var success: Boolean = false
    @SerializedName("em")
    var errorMsg: String? = null

    constructor(parcel: Parcel) : this() {
        requestId = parcel.readString()
        success = parcel.readByte() != 0.toByte()
        errorMsg = parcel.readString()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(requestId)
        parcel.writeByte(if (success) 1 else 0)
        parcel.writeString(errorMsg)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<CancelPartResponse> {
        override fun createFromParcel(parcel: Parcel): CancelPartResponse {
            return CancelPartResponse(parcel)
        }

        override fun newArray(size: Int): Array<CancelPartResponse?> {
            return arrayOfNulls(size)
        }
    }
}