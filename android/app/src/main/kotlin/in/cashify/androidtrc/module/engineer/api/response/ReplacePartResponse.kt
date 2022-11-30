package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 20/10/20.
 */
class ReplacePartResponse() : BaseResponse(),Parcelable {

    @SerializedName("r_id")
    var requestId:String? = null


    @SerializedName("s")
    var success:Boolean = false

    constructor(parcel: Parcel) : this() {
        requestId = parcel.readString()
        success = parcel.readByte() != 0.toByte()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(requestId)
        parcel.writeByte(if (success) 1 else 0)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ReplacePartResponse> {
        override fun createFromParcel(parcel: Parcel): ReplacePartResponse {
            return ReplacePartResponse(parcel)
        }

        override fun newArray(size: Int): Array<ReplacePartResponse?> {
            return arrayOfNulls(size)
        }
    }


}