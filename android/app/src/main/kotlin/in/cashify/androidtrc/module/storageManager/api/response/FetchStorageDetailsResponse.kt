package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class FetchStorageDetailsResponse(
    @SerializedName("dt")
    val storageDetails: StorageDetails?,
    @SerializedName("s")
    val isSuccess: Boolean?,
    @SerializedName("r_id")
    val rId: String?,
    @SerializedName("em")
    val errorMsg: String?
) : BaseResponse(), Parcelable {
    constructor(source: Parcel) : this(
        source.readParcelable<StorageDetails>(StorageDetails::class.java.classLoader),
        source.readValue(Boolean::class.java.classLoader) as Boolean?,
        source.readString(),
        source.readString()
    )



    override fun describeContents() = 0

    override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
        writeParcelable(storageDetails, 0)
        writeValue(isSuccess)
        writeString(rId)
        writeString(errorMsg)
    }

    companion object {
        @JvmField
        val CREATOR: Parcelable.Creator<FetchStorageDetailsResponse> =
            object : Parcelable.Creator<FetchStorageDetailsResponse> {
                override fun createFromParcel(source: Parcel): FetchStorageDetailsResponse =
                    FetchStorageDetailsResponse(source)

                override fun newArray(size: Int): Array<FetchStorageDetailsResponse?> =
                    arrayOfNulls(size)
            }
    }
}