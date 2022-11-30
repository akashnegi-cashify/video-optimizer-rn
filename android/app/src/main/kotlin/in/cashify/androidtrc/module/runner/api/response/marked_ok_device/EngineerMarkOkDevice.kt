package `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class EngineerMarkOkDevice() : BaseResponse(), Parcelable {

    @SerializedName("dt")
    var deviceMap: Map<String, Boolean> = emptyMap()

    constructor(parcel: Parcel) : this() {
        val mapSize = parcel.readInt()
        this.deviceMap = emptyMap()
        for (i in 0 until mapSize) {
            val key = parcel.readString()
            val value = if (parcel.readInt() == 0) true else false
            this.deviceMap.plus(Pair(key, value))
        }
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeInt(this.deviceMap.size)
        for (map: Map.Entry<String, Boolean> in deviceMap.entries.iterator()) {
            parcel.writeString(map.key)
            parcel.writeInt(if (map.value) 1 else 0)
        }
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<EngineerMarkOkDevice> {
        override fun createFromParcel(parcel: Parcel): EngineerMarkOkDevice {
            return EngineerMarkOkDevice(parcel)
        }

        override fun newArray(size: Int): Array<EngineerMarkOkDevice?> {
            return arrayOfNulls(size)
        }
    }
}