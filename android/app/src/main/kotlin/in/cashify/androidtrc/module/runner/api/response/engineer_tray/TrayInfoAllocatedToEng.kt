package `in`.cashify.androidtrc.module.runner.api.response.engineer_tray

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class TrayInfoAllocatedToEng() : BaseResponse(), Parcelable {
    @SerializedName("tbr")
    var trayBarcode: String? = null
    @SerializedName("dc")
    var deviceCount: Int = 0

    constructor(parcel: Parcel) : this() {
        trayBarcode = parcel.readString()
        deviceCount = parcel.readInt()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(trayBarcode)
        parcel.writeInt(deviceCount)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<TrayInfoAllocatedToEng> {
        override fun createFromParcel(parcel: Parcel): TrayInfoAllocatedToEng {
            return TrayInfoAllocatedToEng(parcel)
        }

        override fun newArray(size: Int): Array<TrayInfoAllocatedToEng?> {
            return arrayOfNulls(size)
        }
    }
}