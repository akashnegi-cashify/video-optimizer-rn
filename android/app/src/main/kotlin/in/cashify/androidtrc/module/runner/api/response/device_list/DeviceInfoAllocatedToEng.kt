package `in`.cashify.androidtrc.module.runner.api.response.device_list

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class DeviceInfoAllocatedToEng() : BaseResponse(), Parcelable {
    @SerializedName("eid")
    var engineerId: String? = null
    @SerializedName("en")
    var engineerName: String? = null
    @SerializedName("et")
    var engineerType: String? = null
    @SerializedName("dc")
    var deviceCount: Int = 0

    constructor(parcel: Parcel) : this() {
        engineerId = parcel.readString()
        engineerName = parcel.readString()
        engineerType = parcel.readString()
        deviceCount = parcel.readInt()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(engineerId)
        parcel.writeString(engineerName)
        parcel.writeString(engineerType)
        parcel.writeInt(deviceCount)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<DeviceInfoAllocatedToEng> {
        override fun createFromParcel(parcel: Parcel): DeviceInfoAllocatedToEng {
            return DeviceInfoAllocatedToEng(parcel)
        }

        override fun newArray(size: Int): Array<DeviceInfoAllocatedToEng?> {
            return arrayOfNulls(size)
        }
    }

}