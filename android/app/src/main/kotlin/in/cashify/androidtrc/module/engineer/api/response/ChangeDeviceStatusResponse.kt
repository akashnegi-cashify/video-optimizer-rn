package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class ChangeDeviceStatusResponse() : BaseResponse(), Parcelable {

    @SerializedName("dt")
    val dt: Dt? = null

    @SerializedName("s")
    val isSuccess: Boolean? = null

    @SerializedName("r_id")
    val rId: String? = null

    @SerializedName("em")
    val errorMsg: String? = null

    constructor(parcel: Parcel) : this() {
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {

    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ChangeDeviceStatusResponse> {
        override fun createFromParcel(parcel: Parcel): ChangeDeviceStatusResponse {
            return ChangeDeviceStatusResponse(parcel)
        }

        override fun newArray(size: Int): Array<ChangeDeviceStatusResponse?> {
            return arrayOfNulls(size)
        }
    }


}