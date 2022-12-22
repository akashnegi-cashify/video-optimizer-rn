package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 26,July,2019
 */
class EngineerDeviceInfo() : BaseResponse() ,Parcelable{

    @SerializedName("did")
    var deviceId: String? = null
    @SerializedName("rr")
    var returnReason: String? = null
    @SerializedName("pt")
    var productTitle: String? = null
    @SerializedName("dbr")
    var deviceBarcode: String? = null
    @SerializedName("st")
    var status: String? = null
    var isSelected : Boolean = false

    @SerializedName("rt")
    var repairType: String? = ""

    @SerializedName("gr")
    var grade: String? = ""

    @SerializedName("dimei")
    var imei: String? = null


    @SerializedName("dc")
    var color: String? = null


    @SerializedName("rrs")
    var repairReasonList: ArrayList<String>? = null

    constructor(parcel: Parcel) : this() {
        deviceId = parcel.readString()
        productTitle = parcel.readString()
        deviceBarcode = parcel.readString()
        status = parcel.readString()
        returnReason = parcel.readString()
        isSelected = parcel.readByte() != 0.toByte()
        imei = parcel.readString()
        repairType = parcel.readString()
        grade = parcel.readString()
        color = parcel.readString()
        repairReasonList = parcel.createStringArrayList()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(deviceId)
        parcel.writeString(productTitle)
        parcel.writeString(deviceBarcode)
        parcel.writeString(status)
        parcel.writeString(returnReason)
        parcel.writeByte(if (isSelected) 1 else 0)
        parcel.writeString(imei)
        parcel.writeString(repairType)
        parcel.writeString(grade)
        parcel.writeString(color)
        parcel.writeStringList(repairReasonList)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<EngineerDeviceInfo> {
        override fun createFromParcel(parcel: Parcel): EngineerDeviceInfo {
            return EngineerDeviceInfo(parcel)
        }

        override fun newArray(size: Int): Array<EngineerDeviceInfo?> {
            return arrayOfNulls(size)
        }
    }
}