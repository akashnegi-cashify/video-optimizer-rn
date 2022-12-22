package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class DevicePartList() : BaseResponse(), Parcelable {
    @SerializedName("s")
    var isSuccess: Boolean? = null
    @SerializedName("dt")
    var partInfoList: ArrayList<DevicePartInfo>? = null

    constructor(parcel: Parcel) : this() {
        isSuccess = parcel.readValue(Boolean::class.java.classLoader) as? Boolean
        partInfoList = parcel.createTypedArrayList(DevicePartInfo.CREATOR)
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeValue(isSuccess)
        parcel.writeTypedList(partInfoList)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<DevicePartList> {
        override fun createFromParcel(parcel: Parcel): DevicePartList {
            return DevicePartList(parcel)
        }

        override fun newArray(size: Int): Array<DevicePartList?> {
            return arrayOfNulls(size)
        }
    }
}