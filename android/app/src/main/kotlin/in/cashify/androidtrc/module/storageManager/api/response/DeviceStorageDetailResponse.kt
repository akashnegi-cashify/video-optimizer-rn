package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class DeviceStorageDetailResponse(
    @SerializedName("dt")
    val dt: DeviceDetails?

    , @SerializedName("s")
    val isSuccess: Boolean?

    , @SerializedName("r_id")
    val rId: String?

    , @SerializedName("em")
    val errorMsg: String?


) : BaseResponse(), Parcelable {
    constructor(source: Parcel) : this(
        source.readParcelable<DeviceDetails>(DeviceDetails::class.java.classLoader),
        source.readValue(Boolean::class.java.classLoader) as Boolean?,
        source.readString(),
        source.readString()
    )

    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeParcelable(dt, 0)
        writeValue(isSuccess)
        writeString(rId)
        writeString(errorMsg)
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<DeviceStorageDetailResponse> =
            object : Parcelable.Creator<DeviceStorageDetailResponse> {
                override fun createFromParcel(source: Parcel): DeviceStorageDetailResponse =
                    DeviceStorageDetailResponse(source)

                override fun newArray(size: Int): Array<DeviceStorageDetailResponse?> =
                    arrayOfNulls(size)
            }
    }
}