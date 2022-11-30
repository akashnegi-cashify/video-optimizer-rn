package `in`.cashify.androidtrc.module.storageManager.data

import `in`.cashify.androidtrc.module.engineer.api.response.DeviceDetails
import android.os.Parcel
import android.os.Parcelable

class DeviceDetailsList(val deviceDetailsList: ArrayList<DeviceDetails>?) : Parcelable {
    constructor(parcel: Parcel) : this(parcel.createTypedArrayList(DeviceDetails.CREATOR)) {
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeTypedList(deviceDetailsList)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<DeviceDetailsList> {
        override fun createFromParcel(parcel: Parcel): DeviceDetailsList {
            return DeviceDetailsList(parcel)
        }

        override fun newArray(size: Int): Array<DeviceDetailsList?> {
            return arrayOfNulls(size)
        }
    }
}