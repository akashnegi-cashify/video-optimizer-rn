package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 25/11/20.
 */
class UploadImageResponse() : BaseResponse(),Parcelable {


    @SerializedName("r_id")
    var rid:String? = null


    @SerializedName("s")
    var success:Boolean = false

    constructor(parcel: Parcel) : this() {
        rid = parcel.readString()
        success = parcel.readByte() != 0.toByte()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(rid)
        parcel.writeByte(if (success) 1 else 0)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<UploadImageResponse> {
        override fun createFromParcel(parcel: Parcel): UploadImageResponse {
            return UploadImageResponse(parcel)
        }

        override fun newArray(size: Int): Array<UploadImageResponse?> {
            return arrayOfNulls(size)
        }
    }
}