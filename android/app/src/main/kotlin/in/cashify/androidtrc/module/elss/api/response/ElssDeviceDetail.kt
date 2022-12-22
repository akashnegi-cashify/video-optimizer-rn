package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
class ElssDeviceDetail() : BaseResponse(), Parcelable {

    //TODO need to confirm
    @SerializedName("pid")
    var productId: String? = null

    @SerializedName("dna")
    var deviceName: String? = null

    @SerializedName("imei")
    var imeiNumber: String? = ""

    @SerializedName("dbr")
    var deviceBarcode: String? = null

    @SerializedName("dst")
    var deviceStatus: String? = null

    @SerializedName("drt")
    var deviceRepairType: String? = null //Bulk, Warranty

    @SerializedName("rr")
    var requestReason: String? = null

    @SerializedName("dcl")
    var deviceColor: String? = null

    @SerializedName("isDetailsPresent")
    var isDetailsPresent: Boolean = false

    @SerializedName("rp")
    var partList: ArrayList<ElssPart>? = null


    @SerializedName("rrs")
    var repairReasonList: ArrayList<String>? = null

    constructor(parcel: Parcel) : this() {
        productId = parcel.readString()
        deviceName = parcel.readString()
        deviceBarcode = parcel.readString()
        imeiNumber = parcel.readString()
        deviceStatus = parcel.readString()
        deviceRepairType = parcel.readString()
        requestReason = parcel.readString()
        deviceColor = parcel.readString()
        isDetailsPresent = parcel.readByte() != 0.toByte()
        partList = parcel.createTypedArrayList(ElssPart.CREATOR)
        repairReasonList =parcel.createStringArrayList()

    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(productId)
        parcel.writeString(deviceName)
        parcel.writeString(deviceBarcode)
        parcel.writeString(imeiNumber)
        parcel.writeString(deviceStatus)
        parcel.writeString(deviceRepairType)
        parcel.writeString(requestReason)
        parcel.writeString(deviceColor)
        parcel.writeByte(if (isDetailsPresent) 1 else 0)

        parcel.writeTypedList(partList)
        parcel.writeStringList(repairReasonList)

    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ElssDeviceDetail> {
        override fun createFromParcel(parcel: Parcel): ElssDeviceDetail {
            return ElssDeviceDetail(parcel)
        }

        override fun newArray(size: Int): Array<ElssDeviceDetail?> {
            return arrayOfNulls(size)
        }
    }


}