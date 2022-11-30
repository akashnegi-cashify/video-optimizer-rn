package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 21,August,2019
 */
class DevicePartInfo() : BaseResponse(), Parcelable {
    @SerializedName("pn")
    var partName: String? = null
    @SerializedName("pbr")
    var partBarcode: String? = null
    @SerializedName("dna")
    var deviceName: String? = null
    @SerializedName("sku")
    var partSku: String? = null
    @SerializedName("st")
    var status: String? = null
    @SerializedName("qty")
    var quantity: Int? = null
    @SerializedName("pcl")
    var partColor: String? = null
    var orderQuantity: Int = 0
    var isChecked: Boolean = false

    @SerializedName("pid")
    var partId: Int? = null


    @SerializedName("prid")
    var prid: Int? = null

    constructor(parcel: Parcel) : this() {
        partName = parcel.readString()
        partBarcode = parcel.readString()
        deviceName = parcel.readString()
        partSku = parcel.readString()
        status = parcel.readString()
        quantity = parcel.readValue(Int::class.java.classLoader) as? Int
        partColor = parcel.readString()
        partId = parcel.readValue(Int::class.java.classLoader) as? Int
        orderQuantity = parcel.readInt()
        isChecked = parcel.readByte() != 0.toByte()
        prid =parcel.readValue(Int::class.java.classLoader) as? Int
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(partName)
        parcel.writeString(partBarcode)
        parcel.writeString(deviceName)
        parcel.writeString(partSku)
        parcel.writeString(status)
        parcel.writeValue(quantity)
        parcel.writeString(partColor)
        parcel.writeInt(orderQuantity)
        parcel.writeInt(partId?:0)
        parcel.writeByte(if (isChecked) 1 else 0)
        parcel.writeValue(prid)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<DevicePartInfo> {
        override fun createFromParcel(parcel: Parcel): DevicePartInfo {
            return DevicePartInfo(parcel)
        }

        override fun newArray(size: Int): Array<DevicePartInfo?> {
            return arrayOfNulls(size)
        }
    }

    override fun equals(other: Any?): Boolean {
        if (other is DevicePartInfo) {
            return partName.equals(other.partName)
        }
        return super.equals(other)
    }

}