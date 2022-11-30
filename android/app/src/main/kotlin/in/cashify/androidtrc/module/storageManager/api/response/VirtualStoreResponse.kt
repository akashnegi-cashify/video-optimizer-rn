package `in`.cashify.androidtrc.module.storageManager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

class VirtualStoreResponse(

    @SerializedName("s")
    val isSuccess: Boolean?,
    @SerializedName("r_id")
    val rId: String?,
    @SerializedName("em")
    val errorMsg: String?
) : BaseResponse(), Parcelable {
    constructor(source: Parcel) : this(
         source.readValue(Boolean::class.java.classLoader) as Boolean?,
         source.readString(),
        source.readString()

    )



    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
         writeValue(isSuccess)
        writeString(rId)
        writeString(errorMsg)
    }

    companion object CREATOR : Parcelable.Creator<VirtualStoreResponse> {
        override fun createFromParcel(parcel: Parcel): VirtualStoreResponse {
            return VirtualStoreResponse(parcel)
        }

        override fun newArray(size: Int): Array<VirtualStoreResponse?> {
            return arrayOfNulls(size)
        }
    }


}