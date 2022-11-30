package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import `in`.cashify.androidtrc.module.login.api.TokenResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

class ReceivedPartResponse(

        @SerializedName("r_id")
        var requestId: String? = null,
        @SerializedName("s")
        var success: Boolean = false,
        @SerializedName("em")
        var errorMsg: String? = null

) : BaseResponse(), Parcelable {
        constructor(source: Parcel) : this(
                source.readString(),
                1 == source.readInt(),
                source.readString()
        )

        override fun describeContents() = 0

        override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
                writeString(requestId)
                writeInt((if (success) 1 else 0))
                writeString(errorMsg)
        }

        companion object {
                @JvmField
                val CREATOR: Parcelable.Creator<ReceivedPartResponse> = object : Parcelable.Creator<ReceivedPartResponse> {
                        override fun createFromParcel(source: Parcel): ReceivedPartResponse = ReceivedPartResponse(source)
                        override fun newArray(size: Int): Array<ReceivedPartResponse?> = arrayOfNulls(size)
                }
        }
}